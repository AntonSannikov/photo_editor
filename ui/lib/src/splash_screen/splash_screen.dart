import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:ui/resources/screen_resources.dart';

class SplashScreen extends GScreen {
  SplashScreen({
    super.onLifecycleStateChange$,
    required super.$screenCondition,
    super.key,
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends GScreenState<SplashScreen, Object> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    ScreenResources.screenWidth = mediaQuery.size.width;
    ScreenResources.screenHeight = mediaQuery.size.height;
    ScreenResources.statusBarHeight = mediaQuery.viewPadding.top;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash SCREEN'),
      ),
    );
  }
}
