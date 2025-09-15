import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/api/user_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/value/constant.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/router/routes.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    print("=== Starting email registration ===");

    // Kiểm tra context trước khi thực hiện任何操作
    if (!context.mounted) return;

    final state = context.read<RegisterBlocs>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;
    // Validate input
    final validationError = _validateInput(
      userName,
      email,
      password,
      rePassword,
    );
    if (validationError != null) {
      toastInfo(msg: validationError);
      return;
    }

    User? firebaseUser; // Lưu trữ user để có thể rollback nếu cần

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      firebaseUser = credential.user;

      if (firebaseUser != null) {
        try {
          // Gửi email xác thực
          await firebaseUser.sendEmailVerification();
          print("Email verification sent successfully");

          // Cập nhật thông tin user
          await firebaseUser.updateDisplayName(userName);
          print("Display name updated successfully");

          String photoUrl = "${AppConstant.SERVER_API_URL}uploads/default.png";
          await firebaseUser.updatePhotoURL(photoUrl);
          print("Photo URL updated successfully");

          // Gửi dữ liệu lên backend server
          final backendSuccess = await _registerToBackend(
            firebaseUser,
            userName,
            email,
            photoUrl,
          );
  
        } catch (e) {
          // Nếu có lỗi, cố gắng xóa user Firebase
          if (firebaseUser != null) {
            try {
              await firebaseUser.delete();
            } catch (deleteError) {
              print(
                "Failed to delete Firebase user: ${deleteError.toString()}",
              );
            }
          }
          toastInfo(msg: "Registration failed: ${e.toString()}");
        }
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseError(e);
    } catch (e) {
      toastInfo(msg: "An unexpected error occurred during registration");
    }
  }

  // Hàm kiểm tra dữ liệu đầu vào
  String? _validateInput(
    String userName,
    String email,
    String password,
    String rePassword,
  ) {
    if (userName.isEmpty) {
      return "User name can not be empty";
    }
    if (email.isEmpty) {
      return "Email can not be empty";
    }
    // Kiểm tra định dạng email
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) {
      return "Invalid email format";
    }
    if (password.isEmpty) {
      return "Password can not be empty";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters long";
    }
    if (rePassword.isEmpty) {
      return "Password confirmation can not be empty";
    }
    if (password != rePassword) {
      return "Password and confirmation do not match";
    }
    return null;
  }

  // Hàm xử lý lỗi Firebase
  void _handleFirebaseError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'weak-password':
        errorMessage = "The password provided is too weak";
        break;
      case 'email-already-in-use':
        errorMessage = "The email is already in use";
        break;
      case 'invalid-email':
        errorMessage = "The email id is invalid";
        break;
      case 'operation-not-allowed':
        errorMessage = "Email/password accounts are not enabled";
        break;
      default:
        errorMessage = "Registration failed: ${e.message}";
        break;
    }
    toastInfo(msg: errorMessage);
  }

  Future<bool> _registerToBackend(
    User user,
    String userName,
    String email,
    String photoUrl,
  ) async {
    // Kiểm tra context trước khi show loading
    if (!context.mounted) return false;

    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: false, // Không cho phép dismiss khi đang loading
    );

    try {
      // Tạo LoginRequestEntity cho registration
      LoginRequestEntity registerRequestEntity = LoginRequestEntity();
      registerRequestEntity.avatar = photoUrl;
      registerRequestEntity.name = userName;
      registerRequestEntity.email = email;
      registerRequestEntity.open_id = user.uid;
      registerRequestEntity.type = 1; // type 1 is email registration

      var result = await UserAPI.register(param: registerRequestEntity);
      if (result.code == 200 && result.data != null) {
        // Kiểm tra access_token tồn tại
        if (result.data!.access_token == null ||
            result.data!.access_token!.isEmpty) {
          EasyLoading.dismiss();
          toastInfo(msg: "Invalid token received from backend");
          return false;
        }

        try {
          // Lưu thông tin user vào local storage
          await Global.storageService.setString(
            AppConstant.STORAGE_USER_PROFILE_KEY,
            jsonEncode(result.data!),
          );

          await Global.storageService.setString(
            AppConstant.STORAGE_USER_TOKEN_KEY,
            result.data!.access_token!,
          );

          print("User data saved to local storage successfully");
          EasyLoading.dismiss();

          toastInfo(
            msg:
                "Registration successful! Please check your email for verification.",
          );

          if (context.mounted) {
            print("Navigating to sign in screen");
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRouter.signIn, (route) => false);
            return true;
          } else {
            print("Context is not mounted, cannot navigate");
            return true;
          }
        } catch (e) {
          EasyLoading.dismiss();
          print("Error saving to local storage: ${e.toString()}");
          toastInfo(msg: "Error saving user data");
          return false;
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(
          msg: "Registration failed: ${result.message ?? 'Unknown error'}",
        );
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();

      // Phân loại lỗi chi tiết hơn
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Connection refused')) {
        toastInfo(msg: "Cannot connect to server. Please check your network.");
      } else if (e.toString().contains('TimeoutException')) {
        toastInfo(msg: "Request timeout. Please try again.");
      } else if (e.toString().contains('FormatException')) {
        toastInfo(msg: "Invalid response format from server.");
      } else {
        toastInfo(msg: "Network error: ${e.toString()}");
      }
      return false;
    }
  }
}
