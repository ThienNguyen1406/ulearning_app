import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/themes/app_color.dart';

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.h,
            height: 12.h,
            child: Image.asset("lib/assets/icons/menu.png"),
          ),

          GestureDetector(
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/icons/person.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//reuseable big text widgets
Widget buildHomePageText(
  String text, {
  Color color = AppColors.primaryElementText,
  int top = 20,
}) {
  return Container(
    margin: EdgeInsets.only(top: top!.h),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget searchView() {
  return Row(
    children: [
      Container(
        width: 280.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          border: Border.all(color: AppColors.primaryFourElementText),
          borderRadius: BorderRadius.circular(15.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 17.w),
              width: 16.w,
              height: 16.h,
              child: Image.asset("lib/assets/icons/search.png"),
            ),
            Expanded(
              child: SizedBox(
                width: 240.w,
                height: 40.h,
                child: TextField(
                  // onChanged: (value) => func!(value),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    hintText: "Search your course",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                  autocorrect: false,
                  obscureText: false,
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.circular(13.w),
                  border: Border.all(color: AppColors.primaryElement),
                ),
                child: Image.asset("lib/assets/icons/options.png"),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
