import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/themes/app_color.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';

AppBar buildAppBar() {
  return AppBar(title: Center(child: reusableText("Settings")));
}

Widget settingButton(BuildContext context, void Function()? func) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Logout"),
            content: Text("Confirm Logout"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(onPressed: func, child: Text("Confirm")),
            ],
          );
        },
      );
    },
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 100.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/icons/Logout.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
