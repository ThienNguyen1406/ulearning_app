import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class UserAPI {
  static login({LoginRequestEntity? param}) async {
    //response = response.data after the post method returns
    var response = await HttpUtil().post(
      'api/login',
      queryParameters: param?.toJson(),
    );

    return UserLoginResponseEntity.fromJson(response);
  }
}
