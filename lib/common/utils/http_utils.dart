import 'package:dio/dio.dart';
import 'package:ulearning_app/common/value/constant.dart';
import 'package:ulearning_app/global.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() {
    return _instance;
  }
  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstant.SERVER_API_URL,
      connectTimeout: Duration(seconds: 10), 
      receiveTimeout: Duration(seconds: 10), 
      headers: {
        // "Accept": "application/json",
        // "Content-Type": "application/json; charset=utf-8",
        // "X-Requested-With": "XMLHttpRequest", // Thêm header này
      },
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    );

    dio = Dio(options);
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }

      var response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Request timeout. Please check your connection.");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          "Cannot connect to server. Please check if server is running.",
        );
      } else if (e.response != null) {
        throw Exception("Server error: ${e.response?.statusCode}");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();

    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }
}
