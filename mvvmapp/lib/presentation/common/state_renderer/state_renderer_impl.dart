import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvmapp/presentation/resources/strings_manager.dart';

import '../../../app/constants.dart';

abstract class FlowState {
  StateRendererState getRendererState();
  String getTitle();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererState stateRendererState;
  String title;
  String message;

  LoadingState({
    required this.stateRendererState,
    this.title = Constants.emptyString,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererState getRendererState() => stateRendererState;

  @override
  String getTitle() => title;
}

class SuccessState extends FlowState {
  StateRendererState stateRendererState;
  String title;
  String message;
  SuccessState({
    required this.stateRendererState,
    this.title = Constants.emptyString,
    this.message = AppStrings.resetSuccess,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererState getRendererState() => stateRendererState;

  @override
  String getTitle() => title;
}

class ErrorState extends FlowState {
  StateRendererState stateRendererState;
  String title;
  String message;
  Function? retryFunction;

  ErrorState({
    required this.stateRendererState,
    this.title = Constants.emptyString,
    this.message = AppStrings.error,
    this.retryFunction,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererState getRendererState() => stateRendererState;

  @override
  String getTitle() => title;
}

class EmptyState extends FlowState {
  StateRendererState stateRendererState;
  String title;
  String message;
  Function retryFunction;

  EmptyState({
    required this.stateRendererState,
    this.title = Constants.emptyString,
    this.message = AppStrings.noData,
    required this.retryFunction,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererState getRendererState() => stateRendererState;

  @override
  String getTitle() => title;
}

class StartState extends FlowState {
  @override
  String getMessage() => Constants.emptyString;

  @override
  StateRendererState getRendererState() => StateRendererState.start;

  @override
  String getTitle() => Constants.emptyString;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryFunction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getRendererState() == StateRendererState.loadingPopup) {
            showPopup(context);
            return contentScreenWidget;
          } else {
            return StateRenderer(
              state: getRendererState(),
              retryFunction: retryFunction,
              stateTitle: getTitle(),
              stateMessage: getMessage(),
            );
          }
        }

      case SuccessState:
        {
          _dismissDialog(context);
          if (getRendererState() == StateRendererState.successPopup) {
            showPopup(context);
            return contentScreenWidget;
          } else {
            return StateRenderer(
              state: getRendererState(),
              retryFunction: retryFunction,
              stateTitle: getTitle(),
              stateMessage: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          _dismissDialog(context);
          if (getRendererState() == StateRendererState.errorPopup) {
            showPopup(context);
            return contentScreenWidget;
          } else {
            return StateRenderer(
              state: getRendererState(),
              retryFunction: retryFunction,
              stateTitle: getTitle(),
              stateMessage: getMessage(),
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            state: getRendererState(),
            retryFunction: retryFunction,
            stateTitle: getTitle(),
            stateMessage: getMessage(),
          );
        }
      case StartState:
        {
          _dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          _dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  _dismissDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StateRenderer(
            state: getRendererState(),
            stateTitle: getTitle(),
            stateMessage: getMessage(),
            retryFunction: () {},
          );
        },
      );
    });
  }
}
