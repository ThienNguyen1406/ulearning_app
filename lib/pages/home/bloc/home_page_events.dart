import 'package:ulearning_app/common/entities/entities.dart';

abstract class HomePageEvents {
  const HomePageEvents();
}

class HomePageDots extends HomePageEvents {
  final int index;
  HomePageDots(this.index):super();
}

class HomePageCourseItem extends HomePageEvents{
  const HomePageCourseItem(this.courseItem);
  final List<CourseItem> courseItem;
}