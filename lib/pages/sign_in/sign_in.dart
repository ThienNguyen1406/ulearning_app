import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_events.dart';
import 'package:ulearning_app/pages/sign_in/bloc/signin_states.dart';
import 'package:ulearning_app/pages/sign_in/sign_in_controller.dart';
import 'package:ulearning_app/router/names.dart';
// import 'package:ulearning_app/pages/sign_in/widgets/sign_in_widget.dart';
import 'package:ulearning_app/router/routes.dart';
import 'package:ulearning_app/common/widgets/common_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBlocs, SigninStates>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar("Log In"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buidThirdPartyLogin(context),
                    Center(
                      child: reuseableText(
                        "Or use your email account to login",
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 36.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reuseableText("Email"),
                          SizedBox(height: 5.h),
                          buildTextField(
                            "Enter your email address",
                            "email",
                            "user",
                            (value) {
                              context.read<SigninBlocs>().add(
                                EmailEvent(value),
                              );
                            },
                          ),
                          reuseableText("Password"),
                          SizedBox(height: 5.h),
                          buildTextField(
                            "Enter your password",
                            "password",
                            "lock",
                            (value) {
                              context.read<SigninBlocs>().add(
                                PassWordEvent(value),
                              );
                            },
                          ),
                          forgotPassword(),
                          SizedBox(height: 35.h),
                          buildLogInAdnRegButton("Log in", "login", () {
                            SignInController(
                              context: context,
                            ).handleSignIn("email");
                          }),
                          buildLogInAdnRegButton("Sign Up", "register", () {
                            Navigator.of(context).pushNamed(AppRouter.register);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
