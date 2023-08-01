import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:photo_editor/src/presenters/global_state_impl.dart';
import 'package:photo_editor/src/presenters/navigation/presenter_delegates_impl.dart';

class RootPresenter extends GRootPresenter<RootNavigationDelegate2, AppPresentersGlobalState> {
  @override
  Widget buildApp() => MaterialApp.router(
        onGenerateTitle: (context) {
          return 'PixWizard';
        },
        routerDelegate: navigationDelegate.routerDelegate,
        routeInformationParser: navigationDelegate.routeInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      );
}
