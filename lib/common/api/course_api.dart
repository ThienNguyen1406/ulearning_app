import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class CourseAPI {
  static Future<CourseListResponseEntity> courseList() async{
   var response = await HttpUtil().post(
     'api/courseList'
    );


   return CourseListResponseEntity.fromJson(response);
  }

}