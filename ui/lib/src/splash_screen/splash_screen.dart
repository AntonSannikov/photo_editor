import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:ui/resources/screen.dart';

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
    final size = MediaQuery.of(context).size;
    ScreenResources.screenWidth = size.width;
    ScreenResources.screenHeight = size.height;
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
