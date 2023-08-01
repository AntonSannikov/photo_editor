import 'package:flutter/material.dart';

abstract class ScreenResources {
  static late final double screenWidth;
  static late final double screenHeight;
  static late final double statusBarHeight;
  static const double bottomBarHeight = 80.0;

  static void calculate(MediaQueryData mediaQuery) {
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    statusBarHeight = mediaQuery.viewPadding.top;
  }
}
