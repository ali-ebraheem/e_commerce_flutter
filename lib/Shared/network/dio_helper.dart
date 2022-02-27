import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Dio dio = Dio();

class DioHelper {
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api-app23.herokuapp.com/api/auth/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    @required url,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: data,
    );
  }

  static Future<Response> postData({
    required url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> deleteData({
    required url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
    };
    return await dio.delete(url, data: data);
  }
}
