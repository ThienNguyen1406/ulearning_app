import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';

import '../../common/api/course_api.dart';

class HomeController {
  late BuildContext context;
  UserItem? get userProfile => Global.storageService.getUserProfile();
  static final HomeController _singleton = HomeController._external();
  HomeController._external();

  //factory constructor
  //make sure you have the original onl instance
  factory HomeController({required BuildContext context}){
    _singleton.context = context;

    return _singleton;
  }
  Future<void> init() async {
    // make  sure that user is logged in and then make an api call
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await CourseAPI.courseList();

      if (result.code == 200) {
        if (context.mounted) {
          context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
        } else {
          print(result.code);
        }
      } else {
        print("User is not logged in");
      }
    }
  }
}
