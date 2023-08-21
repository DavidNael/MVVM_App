import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mvvmapp/app/app_prefs.dart';
import 'package:mvvmapp/app/dependency_injection.dart';
import 'package:mvvmapp/presentation/base/base_view_model.dart';
import 'package:mvvmapp/presentation/common/freezed_data_classes.dart';
import 'package:mvvmapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvmapp/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../domain/usecase/login_usecase.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  // Variables
  final StreamController _userNameController =
      StreamController<String>.broadcast();
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  final StreamController _loginButtonController =
      StreamController<void>.broadcast();
  final StreamController isLoggedInController = StreamController<bool>();
  final AppPreferences _appPreferences = getItInstance<AppPreferences>();
  LoginObject _loginObject = LoginObject(email: "", password: "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  //base
  @override
  void dispose() {
    super.dispose();
    _userNameController.close();
    _passwordController.close();
    _loginButtonController.close();
    isLoggedInController.close();
  }

  @override
  void start() {
    inputState.add(StartState());
  }

  //inputs
  @override
  login() async {
    inputState
        .add(LoadingState(stateRendererState: StateRendererState.loadingPopup));
    (await _loginUseCase.execute(
      LoginInput(_loginObject.email, _loginObject.password),
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
        isLoggedInController.add(true);
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
  setUserName(String userName) {
    inputUsername.add(userName);
    _loginObject = _loginObject.copyWith(email: userName);
    _loginButtonController.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    _loginObject = _loginObject.copyWith(password: password);
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
  Stream<bool> get outIsLoginButtonEnabled =>
      _loginButtonController.stream.map((_) => _isValidInputs());

  //Private methods
  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isValidInputs() {
    return _isUserNameValid(_loginObject.email) &&
        _isPasswordValid(_loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputLoginButton;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outIsLoginButtonEnabled;
}
