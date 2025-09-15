import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/themes/app_color.dart';
import 'package:ulearning_app/common/value/constant.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_states.dart';

AppBar buildAppBar(String avatar) {
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
                  image: NetworkImage("${AppConstant.SERVER_API_URL}$avatar"),
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
      // Ô tìm kiếm
      Expanded(
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            border: Border.all(color: AppColors.primaryFourElementText),
            borderRadius: BorderRadius.circular(15.h),
          ),
          child: Row(
            children: [
              SizedBox(width: 17.w),
              SizedBox(
                width: 16.w,
                height: 16.h,
                child: Image.asset("lib/assets/icons/search.png"),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Search your course",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Avenir",
                    fontSize: 14.sp,
                  ),
                  autocorrect: false,
                ),
              ),
            ],
          ),
        ),
      ),

      SizedBox(width: 10.w),
      // Nút filter/options
      GestureDetector(
        onTap: () {},
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
  );
}

Widget slidersView(BuildContext context, HomePageStates state) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 15.h),
        width: 325.w,
        height: 160.h,
        child: PageView(
          onPageChanged: (value) {
            context.read<HomePageBlocs>().add(HomePageDots(value));
          },
          children: [
            _slidersContainer(path: "lib/assets/icons/Art.png"),
            _slidersContainer(path: "lib/assets/icons/Image(1).png"),
            _slidersContainer(path: "lib/assets/icons/Image(2).png"),
          ],
        ),
      ),
      Container(
        child: DotsIndicator(
          dotsCount: 3,
          position: state.index.toDouble(),
          decorator: DotsDecorator(
            color: AppColors.primaryText,
            activeColor: AppColors.primaryElement,
            size: Size.square(5.0),
            activeSize: Size(17.0, 5.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _slidersContainer({String path = "lib/assets/icons/Art.png"}) {
  return Container(
    // margin: EdgeInsets.only(top: 5.h),
    width: 325.w,
    height: 160.h,
    child: PageView(
      children: [
        Container(
          width: 325.w,
          height: 160.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage(path)),
          ),
        ),
      ],
    ),
  );
}

Widget menuView() {
  return Column(
    children: [
      Container(
        width: 325.w,
        margin: EdgeInsets.only(top: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            reusableText(
              "Choose yours course",
              color: AppColors.primaryText,
              fontSize: 16,
            ),
            GestureDetector(
              child: reusableText(
                "See all",
                color: AppColors.primaryThreeElementText,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 5.h),
        child: Row(
          children: [
            _reusableMenuText("All"),
            _reusableMenuText(
              "Popular",
              textColor: AppColors.primaryThreeElementText,
              backgroundColor: AppColors.primarySecondaryBackground,
            ),
            _reusableMenuText(
              "Newest",
              textColor: AppColors.primaryThreeElementText,
              backgroundColor: AppColors.primarySecondaryBackground,
            ),
          ],
        ),
      ),
    ],
  );
}

// reusaboe the menu button
Widget _reusableMenuText(
  String menuText, {
  Color textColor = AppColors.primaryElementText,
  Color backgroundColor = AppColors.primaryElement,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
    margin: EdgeInsets.only(right: 15.w),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(7.w),
      border: Border.all(color: AppColors.primaryElementText),
    ),
    child: Center(
      child: reusableText(
        menuText,
        color: textColor,
        fontWeight: FontWeight.normal,
        fontSize: 11,
      ),
    ),
  );
}
//courseGrid UI

Widget courseGrid(CourseItem item) {
  return Container(
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.w),
      image: DecorationImage(
        image: NetworkImage(AppConstant.SER_UPLOADS + item.thumbnail!),
        fit: BoxFit.fill,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name??"",
          maxLines: 1,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.primaryElementText,
            fontWeight: FontWeight.bold,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          item.description ??"",
          maxLines: 1,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.primaryFourElementText,
            fontWeight: FontWeight.normal,
            fontSize: 11.sp,
          ),
        ),
      ],
    ),
  );
}
