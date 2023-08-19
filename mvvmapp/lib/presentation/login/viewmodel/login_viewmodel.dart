import 'dart:async';

import 'package:mvvmapp/presentation/base/base_view_model.dart';
import 'package:mvvmapp/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  // Variables
  final StreamController _userNameController =
      StreamController<String>.broadcast();
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  final StreamController _loginButtonController =
      StreamController<void>.broadcast();

  LoginObject _loginObject = LoginObject(email: "", password: "");
  // final LoginUseCase _loginUseCase;
  // LoginViewModel(this._loginUseCase);
  //base
  @override
  void dispose() {
    _userNameController.close();
    _passwordController.close();
    _loginButtonController.close();
  }

  @override
  void start() {}

  //inputs
  @override
  login() async {
    // (
    //   await _loginUseCase.execute(
    //     LoginInput(_loginObject.email, _loginObject.password),
    //   )
    // ).fold(
    //   (left) {
    //     if (kDebugMode) print(left.message);
    //   },
    //   (right) {
    //     if (kDebugMode) print(right.customer);
    //   },
    // );
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
    return userName.length > 6 && userName.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.length > 6 && password.isNotEmpty;
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
