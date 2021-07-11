import 'package:dio/dio.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/local/shared_helper.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    print('token ' +
        SharedPreferencesHelper.getSharedLocalData(key: TOKEN).toString());
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              SharedPreferencesHelper.getSharedLocalData(key: TOKEN)
                      .toString() ??
                  null,
          'lang': 'en'
        },
        connectTimeout: 60000,
        //5s
        receiveTimeout: 60000));
    return dio;
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> body,
    Map<String, dynamic> query,
  }) async {
    return await dio.post(url, data: body, queryParameters: query);
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> body,
    Map<String, dynamic> query,
  }) async {
    return await dio.put(url, data: body, queryParameters: query);
  }
}
