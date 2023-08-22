class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String username;
  String countryCode;
  String mobileNumber;
  String profilePicture;
  String email;
  String password;

  RegisterRequest(this.username, this.countryCode, this.mobileNumber,
      this.profilePicture, this.email, this.password);
}

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest(this.email);
}
