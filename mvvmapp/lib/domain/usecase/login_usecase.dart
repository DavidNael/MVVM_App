import 'package:dartz/dartz.dart';
import 'package:mvvmapp/data/network/failure.dart';
import 'package:mvvmapp/domain/models/models.dart';
import 'package:mvvmapp/domain/repository/repository.dart';
import 'package:mvvmapp/domain/usecase/base_usecase.dart';

import '../../data/network/requests.dart';

class LoginUseCase implements BaseUseCase<LoginInput, AuthenticationModel> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, AuthenticationModel>> execute(LoginInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginInput {
  String email;
  String password;
  LoginInput(this.email, this.password);
}
