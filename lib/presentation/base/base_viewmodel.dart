abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // Shared variables and function that will be used through any view model
}

abstract class BaseViewModelInputs {
  void start(); //we will be call while init of view model
  void dispose(); // will be call when view model dies
}

mixin BaseViewModelOutputs {}
