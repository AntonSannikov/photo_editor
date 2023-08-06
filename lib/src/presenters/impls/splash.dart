import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';
import 'package:ui/ui.dart';

@Injectable(as: ISplashPresenter)
class SplashPresenterImpl extends ISplashPresenter {
  late final screenController = GScreenController(
    initialState: SplashScreenState.loading,
    onLifecycleChange$: onLifecycleStateChange,
  );

  void onLifecycleStateChange(GWidgetLifecycle state, BuildContext ctx) {
    switch (state) {
      case GWidgetLifecycle.didChangeDependencies:
        loadAssets(ctx);
        break;
      default:
    }
  }

  Future<void> loadAssets(BuildContext ctx) async {
    ScreenResourcesCalculator.calculate(ctx);
    await Future.delayed(const Duration(seconds: 2));
    setNavigationState(SplashState.initialized);
  }

  @override
  Widget uiBuilder() => SplashScreen(
        screenController: screenController,
      );
}
