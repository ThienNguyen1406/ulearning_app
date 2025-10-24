import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/register/register_controller.dart';
import 'package:ulearning_app/common/widgets/common_widgets.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/pages/register/bloc/register_events.dart';
import 'package:ulearning_app/pages/register/bloc/register_states.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBlocs, RegisterStates>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar("Sign Up"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: reuseableText(
                        "Enter your details below and free signup",
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reuseableText("User name"),
                          buildTextField(
                            "Enter your user name",
                            "name",
                            "user",
                            (value) {
                              context.read<RegisterBlocs>().add(
                                UserNameEvent(value),
                              );
                            },
                          ),
                          reuseableText("Email"),
                          buildTextField(
                            "Enter your email address",
                            "email",
                            "user",
                            (value) {
                              context.read<RegisterBlocs>().add(
                                EmailEvent(value),
                              );
                            },
                          ),
                          reuseableText("Password"),
                          buildTextField(
                            "Enter your password",
                            "password",
                            "lock",
                            (value) {
                              context.read<RegisterBlocs>().add(
                                PasswordEvent(value),
                              );
                            },
                          ),
                          reuseableText("Confirm Password"),
                          buildTextField(
                            "Re-enter your password to confirm",
                            "password",
                            "lock",
                            (value) {
                              context.read<RegisterBlocs>().add(
                                RePasswordEvent(value),
                              );
                            },
                          ),
                          Container(
                            // margin: EdgeInsets.only(left: 25.w),
                            child: reuseableText(
                              "By creating an account you have to agree \n with our them & condication ",
                            ),
                          ),
                          buildLogInAdnRegButton("Sign up", "login", () {
                            RegisterController(
                              context: context,
                            ).handleEmailRegister();
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
