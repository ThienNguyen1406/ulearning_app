import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/api/user_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/value/constant.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:ulearning_app/router/routes.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  /// Xử lý đăng nhập qua email/password
  Future<void> handleSignIn(String type) async {
    if (type != "email") return;

    final state = context.read<SigninBlocs>().state;
    String email = state.email.trim();
    String password = state.password.trim();

    if (email.isEmpty) {
      toastInfo(msg: "Vui lòng nhập email");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "Vui lòng nhập mật khẩu");
      return;
    }

    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
    );

    try {
      // Gửi request đến backend Laravel
      LoginRequestEntity loginRequest = LoginRequestEntity(
        email: email,
        password: password,
      );

      var result = await UserAPI.login(params: loginRequest);

      if (result.code == 200 && result.data != null) {
        // Kiểm tra token
        if (result.data!.access_token == null ||
            result.data!.access_token!.isEmpty) {
          EasyLoading.dismiss();
          toastInfo(msg: "Token không hợp lệ từ server");
          return;
        }

        // ✅ Lưu token & thông tin user vào local
        await Global.storageService.setString(
          AppConstant.STORAGE_USER_PROFILE_KEY,
          jsonEncode(result.data!),
        );

        await Global.storageService.setString(
          AppConstant.STORAGE_USER_TOKEN_KEY,
          result.data!.access_token!,
        );

        EasyLoading.dismiss();

        // ✅ Chuyển về màn hình Home
        if (context.mounted) {
          await HomeController(context: context).init();
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRouter.application, (route) => false);
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: result.message ?? "Đăng nhập thất bại");
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: "Lỗi đăng nhập: ${e.toString()}");
    }
  }
}
