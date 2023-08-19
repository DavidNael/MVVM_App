import 'package:dio/dio.dart';
import 'package:mvvmapp/app/constants.dart';

const String appJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60000;
    Map<String, String> headers = {
      contentType: appJson,
      accept: appJson,
      authorization: "Send token",
      defaultLanguage: "en"
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      sendTimeout: Duration(milliseconds: timeOut),
      receiveTimeout: Duration(milliseconds: timeOut),
    );
    return dio;
  }
}
