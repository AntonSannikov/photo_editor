import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRouterDelegate extends RouterDelegate<String> with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  final List<Page> Function() pageStackBuilder$;
  void Function([bool?]) onPop$;

  AppRouterDelegate({
    required this.pageStackBuilder$,
    required this.onPop$,
  });

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  String? get currentConfiguration => _currentConfiguration;
  late String _currentConfiguration = '';

  void update(String configuration) {
    log('New configuration: $configuration');
    _currentConfiguration = configuration;
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    log('SET NEW ROUTE PATH');
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() async => _onPop();

  bool _onPop([bool? didPop]) {
    onPop$(didPop);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: pageStackBuilder$(),
        onPopPage: (route, result) {
          return _onPop(route.didPop(result));
        });
  }
}

class AppRouteInformationParser extends RouteInformationParser<String> {
  final String Function(String url) parseUrl$ = (String url) => '';

  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    log('PARSE ROUTE');
    return SynchronousFuture(parseUrl$(routeInformation.location ?? ''));
  }

  @override
  RouteInformation restoreRouteInformation(String configuration) {
    log('RESTORE ROUTE: $configuration');
    return RouteInformation(location: configuration);
  }
}
