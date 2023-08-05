import 'package:flutter/material.dart';

class SideToolsPanelResources {
  // panel
  double get dragVelocity => SideToolsPanelResources._dragVelocity;
  static const double _dragVelocity = 1.0;

  Size get panelSize => SideToolsPanelResources._panelSize;
  static late Size _panelSize;

  double get panelClipWidth => SideToolsPanelResources._panelClipWidth;
  static late double _panelClipWidth;

  double get dragAreaHeight => SideToolsPanelResources._dragAreaHeight;
  static late double _dragAreaHeight;

  Size get toolsAreaSize => SideToolsPanelResources._toolsAreaSize;
  static late Size _toolsAreaSize;

  double get panelDragAnimationOffsetTrigger => SideToolsPanelResources._panelDragAnimationOffsetTrigger;
  static late double _panelDragAnimationOffsetTrigger;

  double get closedPanelOffset => SideToolsPanelResources._closedPanelOffset;
  static late double _closedPanelOffset;

  // drag handle
  Size get dragHandleSize => SideToolsPanelResources._dragHandleSize;
  static late Size _dragHandleSize;

  double get dragAreaTopPos => SideToolsPanelResources._dragAreaTopPos;
  static late double _dragAreaTopPos;

  double get dragHandleTopPos => SideToolsPanelResources._dragHandleTopPos;
  static late double _dragHandleTopPos;

  double get dragHandleRightPos => SideToolsPanelResources._dragHandleRightPos;
  static late double _dragHandleRightPos;

  // shaders
  String get rippleShaderAsset => 'ui/shaders/ripple.frag';
  String get barrelDistortionShaderAsset => 'ui/shaders/barrel_distortion.frag';

  // fonts

  // colors

  // strings

  static void calculate({
    required double screenWidth,
    required double screenHeight,
    required double statusBarHeight,
    required double bottomBarHeight,
  }) {
    _panelSize = Size(82.0, screenHeight);
    _panelClipWidth = _panelSize.width / 4;
    _dragAreaHeight = _panelSize.height / 7.3;
    _toolsAreaSize = Size(_panelSize.width - _panelClipWidth, screenHeight - statusBarHeight - kToolbarHeight - bottomBarHeight);
    _panelDragAnimationOffsetTrigger = (_panelSize.width - _panelClipWidth) / 3;
    _closedPanelOffset = _panelSize.width - _panelClipWidth - 2.0;
    _dragHandleSize = Size(_panelSize.width / 2.4, _panelSize.height / 12);
    final double freeScreenSpace = screenHeight - statusBarHeight - kToolbarHeight - bottomBarHeight;
    _dragAreaTopPos = (freeScreenSpace - _dragAreaHeight) / 2;
    _dragHandleTopPos = (freeScreenSpace - _dragHandleSize.height) / 2;
    _dragHandleRightPos = _panelSize.width - _panelClipWidth;
  }
}
