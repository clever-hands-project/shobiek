import 'package:dio/dio.dart';
import 'package:shobek/src/Repository/appLocalization.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();
  static String token;

  Future<Response> get(String url, {Map headerss}) async {
    print(token);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "X-localization": "${localization.currentLanguage}"
    };
    var response;
    try {
      dio.options.baseUrl = "https://cleverhandsthiet.tqnee.net/api/v1/";
      response = await dio.get(url, options: Options(headers: headers));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        print("response: " + e.response.toString());
      } else {}
    }
    return response == null ? null : handleResponse(response);
  }

  Future<Response> post(String url,
      {Map headerss, FormData body, encoding}) async {
    print(token);
   Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "X-localization": "${localization.currentLanguage}"
    };
    var response;
    dio.options.baseUrl = "https://cleverhandsthiet.tqnee.net/api/v1/";
    try {
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        print("response: " + e.response.toString());
      } else {}
    }
    return response == null ? null : handleResponse(response);
  }

  Response handleResponse(Response response) {
    final int statusCode = response.statusCode;
    print("response: " + response.toString());
    if (statusCode >= 200 && statusCode < 300) {
      return response;
    } else {
      return response;
    }
  }
}
