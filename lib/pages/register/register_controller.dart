import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:ulearning_app/common/value/constant.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBlocs>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    // ✅ 1. Kiểm tra dữ liệu đầu vào
    if (userName.isEmpty) {
      toastInfo(msg: "User name cannot be empty");
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: "Email cannot be empty");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "Password cannot be empty");
      return;
    }
    if (password != rePassword) {
      toastInfo(msg: "Password confirmation does not match");
      return;
    }

    try {
      // ✅ 2. Chuẩn bị API endpoint
      final apiUrl = "${AppConstant.SERVER_API_URL}api/register";

      // ✅ 3. Gửi request sang Laravel
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "avatar": "${AppConstant.SERVER_API_URL}uploads/default.png",
          "type": "1", // 🟢 type dạng int (theo DB của bạn)
          "open_id": "flutter_${DateTime.now().millisecondsSinceEpoch}",
          "name": userName,
          "email": email,
          "password": password,
        }),
      );

      // ✅ 4. Xử lý phản hồi từ backend
      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);

        if (resData["status"] == true) {
          toastInfo(msg: "User created successfully!");
          Navigator.of(context).pop();
        } else {
          toastInfo(msg: "Backend error: ${resData["message"]}");
        }
      } else {
        toastInfo(
          msg:
              "Failed to send data to backend: ${response.statusCode}\n${response.body}",
        );
      }
    } catch (e) {
      toastInfo(msg: "Unexpected error: $e");
    }
  }
}
