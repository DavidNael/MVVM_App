import 'package:mvvmapp/data/network/app_api.dart';
import 'package:mvvmapp/data/network/requests.dart';
import 'package:mvvmapp/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient appServiceClient;
  RemoteDataSourceImpl(this.appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
