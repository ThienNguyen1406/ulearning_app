import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/themes/app_color.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/router/names.dart';

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 18.w,
            height: 12.h,
            child: Image.asset("lib/assets/icons/menu.png"),
          ),

          reusableText("Profiles", color: AppColors.primaryText, fontSize: 16),
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset("lib/assets/icons/more-vertical.png"),
          ),
        ],
      ),
    ),
  );
}
//profile icon and edit button

Widget profileIconAndEditButton() {
  return Container(
    width: 80.w,
    height: 80.h,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            image: const DecorationImage(
              image: AssetImage("lib/assets/icons/headpic.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 25.w,
            height: 25.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.asset("lib/assets/icons/edit_3.png"),
          ),
        ),
      ],
    ),
  );
}

//Setting secction button
var imageInfor = <String, String>{
  "Settings": "settings.png",
  "Payment detail": "credit-card.png",
  "Achievement": "award.png",
  "Love": "heart(1).png",
  "Learning Reminders": "cube.png",
};
void func() {}
Widget buildListView(BuildContext context) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        imageInfor.length,
        (index) => GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AppRouter.settings),
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(8.0),
                  // margin: EdgeInsets.symmetric(horizontal: 25.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.primaryElement,
                  ),
                  child: Image(
                    image: AssetImage(
                      "lib/assets/icons/${imageInfor.values.elementAt(index)}",
                    ),
                  ),
                ),
                SizedBox(width: 25.w),
                Text(
                  imageInfor.keys.elementAt(index),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
