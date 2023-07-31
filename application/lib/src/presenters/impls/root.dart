import 'package:application/src/presenters/global_state_impl.dart';
import 'package:application/src/presenters/navigation/presenter_delegates_impl.dart';
import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';

class RootPresenter extends GRootPresenter<RootNavigationDelegate2, AppPresentersGlobalState> {
  @override
  Widget buildApp() => MaterialApp.router(
        title: 'PixWizard',
        routerDelegate: navigationDelegate.routerDelegate,
        routeInformationParser: navigationDelegate.routeInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      );
}
