import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_states.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail_controller.dart';
import 'package:ulearning_app/pages/course/widgets/course_detail_widgets.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late CourseDetailController _courseDetailController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _courseDetailController = CourseDetailController(context: context);
    _courseDetailController.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBlocs, CourseDetailStates>(
      builder: (context, state) {
        return state.courseItem == null
            ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            )
            : Container(
              color: Colors.white,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: buildAppBar(),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 25.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // first big image
                              thumbnail(state.courseItem!.thumbnail.toString()),
                              SizedBox(height: 15.h),
                              // three buttons or menus
                              menuView(),
                              SizedBox(height: 15.h),
                              // course description title
                              reusableText("Course Description"),
                              // course description
                              descriptionText(
                                state.courseItem!.description.toString(),
                              ),
                              SizedBox(height: 20.h),
                              // course button
                              GestureDetector(
                                onTap: () {
                                  _courseDetailController.goBuy(
                                    state.courseItem!.id,
                                  );
                                },
                                child: goBuyButton("Go Buy"),
                              ),
                              SizedBox(height: 20.h),
                              // course summary
                              coureSumaryTitle(),
                              // course summary in list
                              courseSummaryView(context, state),
                              SizedBox(height: 20.h),
                              // Lesson list title
                              reusableText("Lesson List"),
                              // course lesson list
                              courseLessonList(),
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
