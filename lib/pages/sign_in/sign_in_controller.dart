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
import 'package:ulearning_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:ulearning_app/router/routes.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        BlocProvider.of<SigninBlocs>(context).state;
        final state = context.read<SigninBlocs>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          //
          toastInfo(msg: "You need to fill email address");
        }
        if (password.isEmpty) {
          //
          toastInfo(msg: "You need to fill password");
        }
        try {
          final credentail = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: emailAddress,
                password: password,
              );
          if (credentail.user == null) {
            //
            toastInfo(msg: "You don't exist");
          }
          if (!credentail.user!.emailVerified) {
            //
            toastInfo(msg: "You need to verify account");
          }

          var user = credentail.user;
          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            //type 1 is login by email
            loginRequestEntity.type = 1;

            await asyncPostAllData(loginRequestEntity);
            toastInfo(msg: "Login successful");
          } else {
            // we have error getting user from firebase
            toastInfo(msg: "Currently you are not a user of this app");
            return;
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            toastInfo(msg: "No user found for that email");
            return;
          } else if (e.code == 'wrong-password') {
            toastInfo(msg: "Wrong password");
            return;
          } else if (e.code == 'invalid-email') {
            toastInfo(msg: "You email address format is wrong ");
            return;
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    try {
      var result = await UserAPI.login(param: loginRequestEntity);

      if (result.code == 200 && result.data != null) {
        // Kiểm tra token tồn tại
        if (result.data!.access_token == null ||
            result.data!.access_token!.isEmpty) {
          EasyLoading.dismiss();
          toastInfo(msg: "Invalid token received");
          return;
        }
        await Global.storageService.setString(
          AppConstant.STORAGE_USER_PROFILE_KEY,
          jsonEncode(result.data!),
        );
        await Global.storageService.setString(
          AppConstant.STORAGE_USER_TOKEN_KEY,
          result.data!.access_token!,
        );

        EasyLoading.dismiss();
        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRouter.application, (route) => false);
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "Login failed: ${result.message ?? 'Unknown error'}");
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Login error: ${e.toString()}");
      toastInfo(msg: "Login error: ${e.toString()}");
    }
  }
}
