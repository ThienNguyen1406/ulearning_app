import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/themes/app_color.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHomePageText(
              "Hello",
              color: AppColors.primaryThreeElementText,
              top: 20,
            ),
            buildHomePageText(
              "justalone",
              color: AppColors.primaryText,
              top: 5,
            ),
            SizedBox(height: 24.h),
            searchView(),
          ],
        ),
      ),
    );
  }
}
