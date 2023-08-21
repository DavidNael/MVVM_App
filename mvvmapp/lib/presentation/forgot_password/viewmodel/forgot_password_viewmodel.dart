import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mvvmapp/domain/usecase/forgot_password_usecase.dart';
import 'package:mvvmapp/presentation/common/freezed_data_classes.dart';

import '../../base/base_view_model.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewInputs, ForgotPasswordViewOutputs {
  final StreamController<String> _emailController =
      StreamController<String>.broadcast();
  final StreamController<bool> _showResetPasswordController =
      StreamController<bool>.broadcast();
  ForgotPasswordObject _forgotPasswordObject = ForgotPasswordObject(email: "");
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  @override
  void start() {
    inputState.add(StartState());
  }

  @override
  void dispose() {
    _emailController.close();
    super.dispose();
  }

  @override
  forgotPassword() async {
    inputState
        .add(LoadingState(stateRendererState: StateRendererState.loadingPopup));
    (await _forgotPasswordUseCase.execute(
      ForgotPasswordInput(_forgotPasswordObject.email),
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
        if (kDebugMode) print(model.newPassword);
        inputState.add(StartState());
      },
    );
  }

  @override
  Sink get inputEmail => _emailController.sink;
  @override
  Sink get inputResetButton => _showResetPasswordController.sink;

  @override
  Stream<bool> get outIsEmailValid => _emailController.stream.map((email) {
        return isEmailValid(email);
      });
  @override
  Stream<bool> get outResetButton =>
      _showResetPasswordController.stream.map((_) {
        return isEmailValid(_forgotPasswordObject.email);
      });
  @override
  void setUserEmail(String email) {
    inputEmail.add(email);
    _forgotPasswordObject = _forgotPasswordObject.copyWith(email: email);
    _showResetPasswordController.add(true);
  }

  bool isEmailValid(String email) {
    return email.isNotEmpty;
  }
}

abstract class ForgotPasswordViewInputs {
  void setUserEmail(String email);
  forgotPassword();
  Sink get inputEmail;
  Sink get inputResetButton;
}

abstract class ForgotPasswordViewOutputs {
  Stream<bool> get outIsEmailValid;
  Stream<bool> get outResetButton;
}
