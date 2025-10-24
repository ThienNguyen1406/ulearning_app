import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class UserAPI {
  static login({LoginRequestEntity? params}) async {
    var response = await HttpUtil().post('api/login', data: params?.toJson());

    return UserLoginResponseEntity.fromJson(response);
  }

  static register({LoginRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/register',
      data: params?.toJson(),
    );

    return UserLoginResponseEntity.fromJson(response);
  }
}
