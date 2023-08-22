import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mvvmapp/app/app_prefs.dart';
import 'package:mvvmapp/app/dependency_injection.dart';
import 'package:mvvmapp/domain/usecase/register_usecase.dart';
import 'package:mvvmapp/presentation/base/base_view_model.dart';
import 'package:mvvmapp/presentation/common/freezed_data_classes.dart';
import 'package:mvvmapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvmapp/presentation/common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInputs, RegisterViewModelOutputs {
  // Variables
  final StreamController _userNameController =
      StreamController<String>.broadcast();
  final StreamController _countryCodeController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberController =
      StreamController<String>.broadcast();
  final StreamController _profilePictureController =
      StreamController<File>.broadcast();
  final StreamController _emailController =
      StreamController<String>.broadcast();
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  final StreamController _loginButtonController =
      StreamController<void>.broadcast();
  final StreamController isRegisteredInController = StreamController<bool>();
  final AppPreferences _appPreferences = getItInstance<AppPreferences>();
  RegisterObject _registerObject = RegisterObject(
    username: "",
    countryCode: "",
    mobileNumber: "",
    profilePicture: "",
    email: "",
    password: "",
  );
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);
  //base
  @override
  void dispose() {
    super.dispose();
    _userNameController.close();
    _countryCodeController.close();
    _mobileNumberController.close();
    _profilePictureController.close();
    _emailController.close();
    _passwordController.close();
    _loginButtonController.close();
    isRegisteredInController.close();
  }

  @override
  void start() {
    inputState.add(StartState());
  }

  //inputs
  @override
  register() async {
    inputState
        .add(LoadingState(stateRendererState: StateRendererState.loadingPopup));
    (await _registerUseCase.execute(
      RegisterInput(
        _registerObject.username,
        _registerObject.countryCode,
        _registerObject.mobileNumber,
        _registerObject.profilePicture,
        _registerObject.email,
        _registerObject.password,
      ),
    ))
        .fold(
      (failure) {
        inputState.add(ErrorState(
          stateRendererState: StateRendererState.errorPopup,
          message: failure.message,
        ));
        if (kDebugMode) print(failure.message);
      },
      (model) {
        if (kDebugMode) print(model.customer);
        inputState.add(StartState());
        _appPreferences.setIsLoggedIn(true);
        isRegisteredInController.add(true);
      },
    );
  }

  @override
  Sink get inputUsername => _userNameController.sink;

  @override
  Sink get inputPassword => _passwordController.sink;

  @override
  Sink get inputLoginButton => _loginButtonController.sink;
  @override
  Sink get inputCountryCode => _countryCodeController.sink;

  @override
  Sink get inputEmail => _emailController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureController.sink;

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    _registerObject = _registerObject.copyWith(username: userName);
    _loginButtonController.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    _registerObject = _registerObject.copyWith(password: password);
    _loginButtonController.add(null);
  }

  @override
  setCountryCode(String countryCode) {
    inputCountryCode.add(countryCode);
    _registerObject = _registerObject.copyWith(countryCode: countryCode);
    _loginButtonController.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    _registerObject = _registerObject.copyWith(email: email);
    _loginButtonController.add(null);
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    _registerObject = _registerObject.copyWith(mobileNumber: mobileNumber);
    _loginButtonController.add(null);
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    _registerObject =
        _registerObject.copyWith(profilePicture: profilePicture.path);
    _loginButtonController.add(null);
  }

  //outputs
  @override
  Stream<bool> get outIsUsernameValid =>
      _userNameController.stream.map((username) => _isUserNameValid(username));

  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsRegisterButtonEnabled =>
      _loginButtonController.stream.map((_) => _isValidInputs());

  @override
  Stream<bool> get outIsCountryCodeValid => _countryCodeController.stream
      .map((countryCode) => _isCountryCodeValid(countryCode));

  @override
  Stream<bool> get outIsEmailValid =>
      _emailController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outIsMobileNumberValid => _mobileNumberController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<File> get outProfilePicture =>
      _profilePictureController.stream.map((profilePicture) => profilePicture);

  //Private methods
  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isCountryCodeValid(String countryCode) {
    return countryCode.isNotEmpty;
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.isNotEmpty;
  }

  bool _isProfilePictureValid(File profilePicture) {
    return profilePicture.path.isNotEmpty;
  }

  bool _isValidInputs() {
    return _isUserNameValid(_registerObject.email) &&
        _isPasswordValid(_registerObject.password) &&
        _isCountryCodeValid(_registerObject.countryCode) &&
        _isEmailValid(_registerObject.email) &&
        _isMobileNumberValid(_registerObject.mobileNumber) &&
        _registerObject.profilePicture.isNotEmpty;
  }
}

abstract class RegisterViewModelInputs {
  setUserName(String userName);
  setCountryCode(String countryCode);
  setMobileNumber(String mobileNumber);
  setProfilePicture(File profilePicture);
  setEmail(String email);
  setPassword(String password);
  register();

  Sink get inputUsername;
  Sink get inputCountryCode;
  Sink get inputMobileNumber;
  Sink get inputProfilePicture;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputLoginButton;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsCountryCodeValid;
  Stream<bool> get outIsMobileNumberValid;
  Stream<File> get outProfilePicture;
  Stream<bool> get outIsEmailValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outIsRegisterButtonEnabled;
}
