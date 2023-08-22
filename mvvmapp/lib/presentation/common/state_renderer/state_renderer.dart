import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvmapp/app/constants.dart';
import 'package:mvvmapp/presentation/resources/assets_manager.dart';
import 'package:mvvmapp/presentation/resources/color_manager.dart';
import 'package:mvvmapp/presentation/resources/font_manager.dart';
import 'package:mvvmapp/presentation/resources/strings_manager.dart';
import 'package:mvvmapp/presentation/resources/style_manager.dart';
import 'package:mvvmapp/presentation/resources/values_manager.dart';

enum StateRendererState {
  /// Popup States
  loadingPopup,
  errorPopup,
  successPopup,
  // emptyPopup,

  /// Full Screen States
  loadingFullScreen,
  errorFullScreen,
  emptyFullScreen,

  /// General States
  start,
}

class StateRenderer extends StatelessWidget {
  final StateRendererState state;
  final String stateTitle;
  final String stateMessage;
  final Function retryFunction;
  const StateRenderer({
    super.key,
    required this.state,
    this.stateTitle = Constants.emptyString,
    this.stateMessage = AppStrings.loading,
    required this.retryFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (state) {
      case StateRendererState.loadingPopup:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loadingAnimation)]);
      case StateRendererState.successPopup:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.successAnimation),
          _getMessageText(stateMessage),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererState.errorPopup:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.errorAnimation),
          _getMessageText(stateMessage),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererState.loadingFullScreen:
        return _getStateColumn([
          _getAnimatedImage(JsonAssets.loadingAnimation),
          _getMessageText(stateMessage),
        ]);
      case StateRendererState.errorFullScreen:
        return _getStateColumn([
          _getAnimatedImage(JsonAssets.errorAnimation),
          _getMessageText(stateMessage),
          _getRetryButton(AppStrings.retry, context),
        ]);
      case StateRendererState.emptyFullScreen:
        return _getStateColumn([
          _getAnimatedImage(JsonAssets.emptyAnimation),
          _getMessageText(stateMessage),
        ]);
      case StateRendererState.start:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getStateColumn(List<Widget> list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> list) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: ColorManager.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black26,
              blurRadius: AppSize.s10,
              offset: const Offset(0.0, AppSize.s10),
            ),
          ],
        ),
        child: _getDialogContent(context, list),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  Widget _getAnimatedImage(String animationPath) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationPath),
    );
  }

  Widget _getMessageText(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularTextStyle(
              fontSize: FontSize.s18, color: ColorManager.black),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonText, BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p18),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (state == StateRendererState.errorFullScreen) {
              retryFunction.call();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonText),
        ),
      ),
    );
  }
}
