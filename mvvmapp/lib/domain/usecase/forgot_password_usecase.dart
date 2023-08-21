import 'package:dartz/dartz.dart';
import 'package:mvvmapp/data/network/failure.dart';
import 'package:mvvmapp/data/network/requests.dart';
import 'package:mvvmapp/domain/models/models.dart';
import 'package:mvvmapp/domain/repository/repository.dart';
import 'package:mvvmapp/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase
    implements BaseUseCase<ForgotPasswordInput, ForgotPasswordModel> {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPasswordModel>> execute(
      ForgotPasswordInput input) {
    return _repository.forgotPassword(ForgotPasswordRequest(input.email));
  }
}

class ForgotPasswordInput {
  String email;
  ForgotPasswordInput(this.email);
}
