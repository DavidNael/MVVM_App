import 'package:mvvmapp/data/network/app_api.dart';
import 'package:mvvmapp/data/network/requests.dart';
import 'package:mvvmapp/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<HomeResponse> getHome();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient appServiceClient;
  RemoteDataSourceImpl(this.appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest loginRequest) async {
    return await appServiceClient.register(
      loginRequest.username,
      loginRequest.countryCode,
      loginRequest.mobileNumber,
      "",
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    return await appServiceClient.forgotPassword(forgotPasswordRequest.email);
  }

  @override
  Future<HomeResponse> getHome() async {
    return await appServiceClient.getHome();
  }
}
