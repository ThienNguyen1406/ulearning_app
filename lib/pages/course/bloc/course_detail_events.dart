import 'package:ulearning_app/common/entities/entities.dart';

abstract class CourseDetailEvents {
  const CourseDetailEvents();
}

class TriggerCourseDetailEvent extends CourseDetailEvents {
  const TriggerCourseDetailEvent(this.courseItem) : super();
  final CourseItem courseItem;
}
