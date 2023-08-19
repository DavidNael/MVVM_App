import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvmapp/app/app_prefs.dart';
import 'package:mvvmapp/app/constants.dart';

const String appJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    final language=await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      contentType: appJson,
      accept: appJson,
      authorization: Constants.sendToken,
      defaultLanguage: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      sendTimeout: const Duration(milliseconds: Constants.apiTimeout),
      receiveTimeout: const Duration(milliseconds: Constants.apiTimeout),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          responseHeader: true,
          requestBody: true,
        ),
      );
    }
    return dio;
  }
}
