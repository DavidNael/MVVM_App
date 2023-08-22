import 'package:dartz/dartz.dart';
import 'package:mvvmapp/data/network/failure.dart';
import 'package:mvvmapp/domain/models/models.dart';
import 'package:mvvmapp/domain/repository/repository.dart';
import 'package:mvvmapp/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeModel> {
  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeModel>> execute(void input) async {
    return await _repository.getHome();
  }
}
