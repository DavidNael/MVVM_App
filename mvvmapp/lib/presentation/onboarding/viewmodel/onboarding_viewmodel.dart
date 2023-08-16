import 'dart:async';

import 'package:mvvmapp/domain/models.dart';

import '../../base/base_view_model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewInputs, OnBoardingViewOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int currentPageIndex = 0;

  // Inputs
  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goBack() {
    int previousIndex = currentPageIndex - 1;
    if (previousIndex < 0) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  int goNext() {
    int nextIndex = currentPageIndex + 1;
    if (nextIndex > _list.length - 1) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  void onPageChanged(int index) {
    currentPageIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // Outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private methods
  List<SliderObject> _getSliderData() {
    return [
      SliderObject(AppStrings.onBoardingTitleText1,
          AppStrings.onBoardingBodyText1, ImageAssets.onBoardingLogo1),
      SliderObject(AppStrings.onBoardingTitleText2,
          AppStrings.onBoardingBodyText2, ImageAssets.onBoardingLogo2),
      SliderObject(AppStrings.onBoardingTitleText3,
          AppStrings.onBoardingBodyText3, ImageAssets.onBoardingLogo3),
      SliderObject(AppStrings.onBoardingTitleText4,
          AppStrings.onBoardingBodyText4, ImageAssets.onBoardingLogo4),
    ];
  }

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        _list[currentPageIndex], _list.length, currentPageIndex));
  }
}

abstract class OnBoardingViewInputs {
  int goNext();
  int goBack();
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
