import 'package:dartz/dartz.dart';
import 'package:mvvmapp/data/network/failure.dart';
import 'package:mvvmapp/domain/models/models.dart';
import 'package:mvvmapp/domain/repository/repository.dart';
import 'package:mvvmapp/domain/usecase/base_usecase.dart';

import '../../data/network/requests.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterInput, AuthenticationModel> {
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, AuthenticationModel>> execute(
      RegisterInput input) async {
    return await _repository.register(RegisterRequest(
        input.username,
        input.countryCode,
        input.mobileNumber,
        input.profilePicture,
        input.email,
        input.password));
  }
}

class RegisterInput {
  String username;
  String countryCode;
  String mobileNumber;
  String profilePicture;
  String email;
  String password;
  RegisterInput(this.username, this.countryCode, this.mobileNumber,
      this.profilePicture, this.email, this.password);
}
