import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/themes/app_color.dart';
import 'package:ulearning_app/common/value/constant.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_states.dart';

AppBar buildAppBar() {
  return AppBar(title: reusableText("Course Detail"));
}

Widget thumbnail(String thumbNail) {
  return Container(
    width: 325.w,
    height: 200.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage("${AppConstant.SERVER_UPLOADS}$thumbnail"),
        fit: BoxFit.fitWidth,
      ),
    ),
  );
}

Widget menuView() {
  return SizedBox(
    width: 325.w,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: AppColors.primaryElement),
            ),
            child: reusableText(
              "Author Page",
              color: AppColors.primaryElementText,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        _iconAndNum("lib/assets/icons/people.png", 0),
        _iconAndNum("lib/assets/icons/start.png", 0),
      ],
    ),
  );
}

Widget _iconAndNum(String iconPath, int num) {
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(image: AssetImage(iconPath), width: 20.w, height: 20.h),

        reusableText(
          num.toString(),
          color: AppColors.primaryThreeElementText,
          fontSize: 11,
          fontWeight: FontWeight.normal,
        ),
      ],
    ),
  );
}

Widget goBuyButton(String buttonName) {
  return Container(
    padding: EdgeInsets.only(top: 13.h),
    width: 330.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: AppColors.primaryElement,
      border: Border.all(color: AppColors.primaryElement),
      borderRadius: BorderRadius.circular(10.w),
    ),
    child: Text(
      buttonName,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryThreeElementText,
        fontWeight: FontWeight.normal,
        fontSize: 16.sp,
      ),
    ),
  );
}

Widget descriptionText(String description) {
  return reusableText(
    description,
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryThreeElementText,
  );
}

Widget coureSumaryTitle() {
  return reusableText("The Course Includes", fontSize: 14);
}

Widget courseSummaryView(BuildContext context, CourseDetailStates state) {
  //Setting secction button
  var imageInfor = <String, String>{
    "${state.courseItem!.video_len ?? "0"}Hours Videos": "video_detail.png",
    "Total ${state.courseItem!.lesson_num ?? "0"} Lessons": "file_detail.png",
    "${state.courseItem!.down_num ?? "0"} Downloadale Resources ":
        "download_detail.png",
  };

  return Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        imageInfor.length,
        (index) => GestureDetector(
          onTap: () => null,
          child: Container(
            margin: EdgeInsets.only(top: 15.h),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.primaryElement,
                  ),
                  child: Image(
                    image: AssetImage(
                      "lib/assets/icons/${imageInfor.values.elementAt(index)}",
                    ),
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
                SizedBox(width: 25.w),
                Text(
                  imageInfor.keys.elementAt(index),
                  style: TextStyle(
                    color: AppColors.primarySecondaryElementText,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
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

Widget courseLessonList() {
  return Container(
    width: 325.w,
    height: 80.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 1),
      borderRadius: BorderRadius.circular(10.h),
      border: Border.all(),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //for image and the text
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.h),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("lib/assets/icons/Image(1).png"),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //list item title
                  _buildListContaier(),
                  //list item desc
                  _buildListContaier(
                    fontSize: 13,
                    color: AppColors.primaryText,
                    fontweight: FontWeight.normal,
                  ),
                ],
              ),
            ],
          ),
          //for showing the right arrow
          Container(
            child: Image(
              height: 24.h,
              width: 24.h,
              image: AssetImage("lib/assets/icons/arrow_right.png"),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildListContaier({
  double fontSize = 13,
  Color color = AppColors.primaryText,
  FontWeight fontweight = FontWeight.bold,
}) {
  return Container(
    width: 200.w,
    margin: EdgeInsets.only(left: 6.w),
    child: Text(
      "UI Design",
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontweight,
      ),
    ),
  );
}
