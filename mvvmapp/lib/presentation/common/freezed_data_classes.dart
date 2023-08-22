import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject({
    required String email,
    required String password,
  }) = _LoginObject;
}

@freezed
class ForgotPasswordObject with _$ForgotPasswordObject {
  factory ForgotPasswordObject({
    required String email,
  }) = _ForgotPasswordObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject({
    required String username,
    required String countryCode,
    required String mobileNumber,
    required String profilePicture,
    required String email,
    required String password,
  }) = _RegisterObject;
}
