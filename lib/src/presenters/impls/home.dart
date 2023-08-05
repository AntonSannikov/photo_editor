import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';
import 'package:ui/ui.dart';

@Injectable(as: IHomePresenter)
class HomePresenterImpl extends IHomePresenter {
  late final screenController = GScreenController(onLifecycleChange$: onLifecycleStateChange);

  final $appBarTitle = ValueNotifier('home');
  final $tabIndex = ValueNotifier(0);

  @override
  void dispose() {}

  @override
  void onChildRouteChange(HomeState value) {
    switch (value) {
      case HomeState.showCanvasTab:
        $appBarTitle.value = 'Canvas';
        $tabIndex.value = 0;
        break;
      case HomeState.showSettingsTab:
        $appBarTitle.value = 'Settings';
        $tabIndex.value = 1;
        break;
      default:
    }
  }

  void onLifecycleStateChange(GWidgetLifecycle state, BuildContext ctx) {
    switch (state) {
      case GWidgetLifecycle.didChangeDependencies:
        break;
      default:
    }
  }

  void onBottomBarTap(int index) {
    switch (index) {
      case 0:
        setNavigationState(HomeState.showCanvasTab);
      case 1:
        setNavigationState(HomeState.showSettingsTab);
    }
  }

  void onCameraButtonTap() => setNavigationState(HomeState.openCamera);

  void onGalleryButtonTap() => setNavigationState(HomeState.openGallery);

  @override
  Widget uiBuilder() => HomeScreen(
        screenController: screenController,
        navigationWidget: navigationWidget,
        onCameraButtonTap$: onCameraButtonTap,
        onGalleryButtonTap$: onGalleryButtonTap,
        onBottomBarTap$: onBottomBarTap,
        $appBarTitle: $appBarTitle,
        $tabIndex: $tabIndex,
      );
}
