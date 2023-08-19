import 'package:dio/dio.dart';
import 'package:mvvmapp/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECTION_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
            error.response!.statusCode!, error.response!.statusMessage!);
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.unknown:
      return DataSource.UNKNOWN.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  No_CONTENT,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  SERVICE_UNAVAILABLE,
  NO_INTERNET_CONNECTION,
  CONNECTION_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  DEFAULT,
  UNKNOWN,
}

extension DataSouceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.No_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.SERVICE_UNAVAILABLE:
        return Failure(ResponseCode.SERVICE_UNAVAILABLE,
            ResponseMessage.SERVICE_UNAVAILABLE);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.CONNECTION_TIMEOUT:
        return Failure(ResponseCode.CONNECTION_TIMEOUT,
            ResponseMessage.CONNECTION_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      case DataSource.UNKNOWN:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      default:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }
}

class ResponseCode {
  //server error codes
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int SERVICE_UNAVAILABLE = 503;

  //local error codes
  static const int CONNECTION_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
  static const int UNKNOWN = -8;
}

class ResponseMessage {
  static const String SUCCESS = 'Success';
  static const String NO_CONTENT = 'No Content';
  static const String BAD_REQUEST = 'Bad Request, Please try again.';
  static const String UNAUTHORIZED = 'User is not authorized, try again later.';
  static const String FORBIDDEN = 'Forbidden Access Denied';
  static const String NOT_FOUND = 'Not Found';
  static const String INTERNAL_SERVER_ERROR =
      'Something went wrong, please try again later.';
  static const String SERVICE_UNAVAILABLE = 'Service Unavailable';
  static const String CONNECTION_TIMEOUT =
      'Connection Timeout, Please try again.';
  static const String CANCEL = 'Request was Cancelled';
  static const String RECEIVE_TIMEOUT = 'Connection Timeout, Please try again.';
  static const String SEND_TIMEOUT = 'Connection Timeout, Please try again.';
  static const String CACHE_ERROR = 'Cache Error';
  static const String NO_INTERNET_CONNECTION =
      'No Internet Connection, check your connection and try again.';
  static const String DEFAULT = 'Something went wrong, please try again later.';
  static const String UNKNOWN = 'Something went wrong, please try again later.';
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int ERROR = 1;
}
