import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class CourseAPI {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post('api/courseList');

    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseDetailResponseEntity> courseDetail({
    CourseRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'api/courseDetail',
      queryParameters: params?.toJson(),
    );

    return CourseDetailResponseEntity.fromJson(response);
  }

  //for payment
  static Future<BaseResponseEntity> coursePay({
    CourseRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      "/api/checkout",
      queryParameters: params?.toJson(),
    );

    return BaseResponseEntity.fromJson(response);
  }
}
