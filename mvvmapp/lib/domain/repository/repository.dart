import 'package:dartz/dartz.dart';
import 'package:mvvmapp/data/network/requests.dart';

import '../../data/network/failure.dart';
import '../models/models.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationModel>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(ForgotPasswordRequest loginRequest);
}