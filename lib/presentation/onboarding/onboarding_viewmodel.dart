import 'dart:async';

import 'package:clean_architecture/domain/model.dart';
import 'package:clean_architecture/presentation/base/base_viewmodel.dart';
import 'package:clean_architecture/presentation/resources/assets_manager.dart';
import 'package:clean_architecture/presentation/resources/string_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController<SlideViewObject> _streamController =
      StreamController<SlideViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send this data to the view
    _postDataView();
  }

  @override
  int goNext() {
    // TODO: implement goNext
    int nextIndex = _currentIndex++; // +1
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    // TODO: implement goPrevious
    int previousIndex = _currentIndex--; // -1
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider list
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
    _currentIndex = index;
    _postDataView();
  }

  @override
  // TODO: implement slideViewObject
  Sink<SlideViewObject> get inputSlideViewObject => _streamController.sink;

  @override
  // TODO: implement outputSlideViewObject
  Stream<SlideViewObject> get outputSlideViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4)
      ];
  _postDataView() {
    inputSlideViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

mixin OnboardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  Sink<SlideViewObject> get inputSlideViewObject;
}

mixin OnboardingViewModelOutputs {
  Stream<SlideViewObject> get outputSlideViewObject;
}

class SlideViewObject {
  final SliderObject sliderObject;
  final int numOfSlides;
  final int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
