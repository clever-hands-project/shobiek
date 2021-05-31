import 'package:dio/dio.dart';
import 'package:shobek/src/Models/chat/base_model.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio _dio = Dio();

  // SharedPreferenceManager _sharedHelper = SharedPreferenceManager();

  Future<dynamic> get(String url,
      {bool withToken = false, BaseModel model,String token}) async {
    Response _response;
    // String _token;
    try {
      if (withToken) {
        // _token = await _sharedHelper.readString(CachingKey.AUTH_TOKEN);
        _dio.options.headers = {
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data"
        };
      }
      _dio.options.baseUrl = "https://shobaik-lobaik.com/api/v1/";
      _response = await _dio.get(url);
      print("Correct request: " + _response.toString());
    } on DioError catch (e) {
      _response = e.response;
      print("Exception: " + e.response.toString());
    }
    if (model == null) {
      return _response;
    } else {
      return model.fromJson(_response.data);
    }
  }

  Future<dynamic> post(String url,
      {FormData body, bool withToken = false, BaseModel model}) async {
    Response _response;
    String _token;
    _dio.options.baseUrl = "https://shobaik-lobaik.com/api/v1/";
    try {
      if (withToken) {
        // _token = await _sharedHelper.readString(CachingKey.AUTH_TOKEN);
        _dio.options.headers = {
          'Authorization': 'Bearer $_token',
          "Content-Type": "multipart/form-data"
        };
      }
      _response = await _dio.post(url, data: body);
      print("Correct request: " + _response.toString());
    } on DioError catch (e) {
      _response = e.response;
      print("Exception: " + e.response.toString());
    }
    if (model == null) {
      return _response;
    } else {
      return model.fromJson(_response.data);
    }
  }
}
