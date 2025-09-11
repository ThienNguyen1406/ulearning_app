import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/themes/app_color.dart';

Widget reusableText(
  String text, {
  Color color = AppColors.primaryText,
  int? fontSize,
  FontWeight? fontWeight = FontWeight.bold,
}) {
  return Container(
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize?.sp,
      ),
    ),
  );
}