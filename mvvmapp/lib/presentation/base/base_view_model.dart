abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
}

abstract class BaseViewModelOutputs {}
