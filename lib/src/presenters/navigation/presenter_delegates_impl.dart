import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:photo_editor/src/presenters/navigation/nav2_core.dart';

class ShellNavigationDelegate2 extends GPresenterNavigationDelegate {
  late final routerDelegate = AppRouterDelegate(
    pageStackBuilder$: () => _pages,
    onPop$: onPop,
  );
  @override
  late final Widget navigationWidget = Router(routerDelegate: routerDelegate);

  List<Page> _pages = [];

  @override
  void updateWidgetTree(List<GRoute> routeStack) {
    _pages = routeStack.map(_convertGRouteToPage).toList();
    routerDelegate.update(appCurrentPath);
  }

  Page _convertGRouteToPage(GRoute route) => MaterialPage(
        key: ValueKey(route.id.name),
        child: route.presenter!.uiBuilder(),
      );
}

class RootNavigationDelegate2 extends ShellNavigationDelegate2 {
  final routeInformationParser = AppRouteInformationParser();
}
