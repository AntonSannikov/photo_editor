import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:ui/resources/screen_resources.dart';
import 'package:ui/src/canvas_screen/widgets/side_tools_panel/side_tools_panel_resources.dart';

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
    ScreenResources.calculate(MediaQuery.of(context));
    SideToolsPanelResources.calculate(
        screenWidth: ScreenResources.screenWidth,
        screenHeight: ScreenResources.screenHeight,
        statusBarHeight: ScreenResources.statusBarHeight,
        bottomBarHeight: ScreenResources.bottomBarHeight);
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
