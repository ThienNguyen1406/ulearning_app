import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    if (userName.isEmpty) {
      toastInfo(msg: "User name can not be empty");
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: "Emailcan not be empty");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "Password can not be empty");
      return;
    }
    if (rePassword.isEmpty) {
      toastInfo(msg: "Your password confirm is wrong");
      return;
    }

    try {
      final credentail = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credentail.user != null) {
        //send confirm email
        await credentail.user?.sendEmailVerification();
        //set update username
        await credentail.user?.updateDisplayName(userName);

        String photoUrl = "uploads/default.png";

        await credentail.user?.updatePhotoURL(photoUrl);
        toastInfo(
          msg:
              "An email has been sent to your registered email. To activitve it click on the link",
        );
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "The password provided is too weak");
      }
      if (e.code == 'email-already-in-use') {
        toastInfo(msg: "The email is already in use");
      }
      if (e.code == 'invalid-email') {
        toastInfo(msg: "The email id is invalid");
      }
    }
  }
}
