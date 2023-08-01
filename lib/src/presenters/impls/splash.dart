import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/entrypoint.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';
import 'package:ui/ui.dart';

@Injectable(as: ISplashPresenter)
class SplashPresenterImpl extends ISplashPresenter {
  @override
  void onStart() async {
    await Future.delayed(const Duration(seconds: 2));
    setNavigationState(SplashState.initialized);
  }

  void onLifecycleStateChange(GWidgetLifecycle state) {
    switch (state) {
      case GWidgetLifecycle.onInit:
        loadAssets();
        break;
      default:
    }
  }

  Future<void> loadAssets() async {
    await Future.delayed(const Duration(seconds: 2));
    setNavigationState(SplashState.initialized);
  }

  @override
  Widget uiBuilder() => SplashScreen(
        $screenCondition: defaultConditionNotifier,
        onLifecycleStateChange$: onLifecycleStateChange,
      );
}
