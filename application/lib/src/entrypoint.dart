import 'package:application/src/di/injection.dart';
import 'package:application/src/presenters/global_state_impl.dart';
import 'package:application/src/presenters/presenters_factory_injectable_impl.dart';
import 'package:application/src/presenters/interfaces.dart';
import 'package:application/src/presenters/navigation/presenter_delegates_impl.dart';
import 'package:application/src/presenters/impls/root.dart';
import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';

enum SplashState { initialized }

enum HomeState { showCanvasTab, showSettingsTab, openGallery, openCamera }

enum AppRoute {
  splash,
  home,
  canvas,
  settings,
  gallery,
  camera,
}

final _appCore = ApplicationCore<AppPresentersGlobalState>(
  presentersState: AppPresentersGlobalState(),
  presentersFactory: AppPresentersFactory(),
  routeTree: GRoot<RootPresenter, RootNavigationDelegate2, AppPresentersGlobalState>(
    navigationDelegate: RootNavigationDelegate2(),
    children: [
      GRoute<ISplashPresenter, SplashState, AppPresentersGlobalState>(
        id: AppRoute.splash,
        mapStateToRouteId$: (_) => switch (_) {
          SplashState.initialized => AppRoute.home,
        },
      ),
      GRoute<IGalleryPresenter, Enum, AppPresentersGlobalState>(
        id: AppRoute.gallery,
        stack: [AppRoute.home],
      ),
      GRoute<ICameraPresenter, Enum, AppPresentersGlobalState>(
        id: AppRoute.camera,
        stack: [AppRoute.home],
      ),
      GShell<IHomePresenter, HomeState, ShellNavigationDelegate2, AppPresentersGlobalState>(
          id: AppRoute.home,
          navigationDelegate: ShellNavigationDelegate2(),
          shellStateValues: HomeState.values,
          mapStateToRouteId$: (_) => switch (_) {
                HomeState.showCanvasTab => AppRoute.canvas,
                HomeState.showSettingsTab => AppRoute.settings,
                HomeState.openGallery => AppRoute.gallery,
                HomeState.openCamera => AppRoute.camera,
              },
          children: [
            GRoute<ICanvasPresenter, Enum, AppPresentersGlobalState>(
              id: AppRoute.canvas,
              isTab: true,
            ),
            GRoute<ISettingsPresenter, Enum, AppPresentersGlobalState>(
              id: AppRoute.settings,
              isTab: true,
            ),
          ]),
    ],
  ),
);

class AppEntryPoint {
  void run() {
    configureDependencies();
    _appCore.initializeApp();
    runApp(_appCore.appWidget);
  }
}
