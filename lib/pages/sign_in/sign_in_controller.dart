import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        //BlocProvider.of<SignInBlocs>(context).state
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
            //we got verified user form firebase
            Global.storageService.setString(
              AppConstant.STORAGE_USER_TOKEN_KEY,
              "12345678",
            );
            toastInfo(msg: "Login successful");
            Navigator.of(context).pushNamed(AppRouter.application);
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
}
