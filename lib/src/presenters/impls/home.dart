import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/entrypoint.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';
import 'package:ui/ui.dart';

@Injectable(as: IHomePresenter)
class HomePresenterImpl extends IHomePresenter {
  @override
  late ValueListenable<String> $appBarTitle;

  int _tabIndex = 0;

  @override
  void dispose() {}

  @override
  void onChildRouteChanged(HomeState state) {
    switch (state) {
      case HomeState.showCanvasTab:
        _tabIndex = 0;
        break;
      case HomeState.showSettingsTab:
        _tabIndex = 1;
        break;
      default:
    }
  }

  void onLifecycleStateChange(GWidgetLifecycle state) {
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
        navigationWidget: navigationWidget,
        onCameraButtonTap: onCameraButtonTap,
        onGalleryButtonTap: onGalleryButtonTap,
        onBottomBarTap: onBottomBarTap,
        appBarTitle: $appBarTitle.value,
        tabIndex: _tabIndex,
        $screenCondition: defaultConditionNotifier,
        onLifecycleStateChange$: onLifecycleStateChange,
      );
}
