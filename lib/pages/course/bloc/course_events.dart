import 'package:ulearning_app/common/entities/entities.dart';

abstract class CourseEvents {
  const CourseEvents();
}

class TriggerCourseEvent extends CourseEvents {
  const TriggerCourseEvent(this.courseItem) : super();
  final CourseItem courseItem;
}
