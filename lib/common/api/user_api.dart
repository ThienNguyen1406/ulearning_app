import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class UserAPI {
  static login({LoginRequestEntity? param}) async {
    //response = response.data after the post method returns
    var response = await HttpUtil().post('api/login', data: param?.toJson());
    return UserLoginResponseEntity.fromJson(response);
  }

  static register({LoginRequestEntity? param}) async {
    //response = response.data after the post method returns
    var response = await HttpUtil().post(
      'api/register',
      data: param?.toJson(),
    );
    return UserLoginResponseEntity.fromJson(response);
  }
}
