import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvmapp/data/data_source/remote_data_source.dart';
import 'package:mvvmapp/data/mapper/mapper.dart';

import 'package:mvvmapp/data/network/failure.dart';
import 'package:mvvmapp/data/network/network_info.dart';

import 'package:mvvmapp/data/network/requests.dart';

import 'package:mvvmapp/domain/models/models.dart';

import '../../domain/repository/repository.dart';
import '../network/error_handler.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.error,
              response.message ?? ResponseMessage.defaultError));
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error is: $e");
        }
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(
        DataSource.noInternetConnection.getFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.forgotPassword(forgotPasswordRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.error,
              response.message ?? ResponseMessage.defaultError));
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error is: $e");
        }
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(
        DataSource.noInternetConnection.getFailure(),
      );
    }
  }
}
