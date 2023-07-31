import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui/resources/screen.dart';
import 'package:ui/src/canvas_screen/widgets/drag_handle.dart';

class SideToolsPanel extends StatefulWidget {
  const SideToolsPanel({Key? key}) : super(key: key);

  @override
  State<SideToolsPanel> createState() => _SideToolsPanelState();
}

class _SideToolsPanelState extends State<SideToolsPanel> with SingleTickerProviderStateMixin {
  final panelWidth = ScreenResources.screenWidth / 5;
  final panelHeight = ScreenResources.screenHeight;
  late final panelWidthOffset = panelWidth / 4;
  final dragAreaHeight = ScreenResources.screenHeight / 7.5;
  final dragHandleWidth = ScreenResources.screenWidth / 12;
  final dragHandleHeight = ScreenResources.screenHeight / 12;
  late final dragHandleTopPos =
      (ScreenResources.screenHeight - ScreenResources.appBarHeight - ScreenResources.bottomBatHeight - kToolbarHeight - dragHandleHeight) /
          2;
  late final dragHandleRightPos = panelWidth - panelWidthOffset - dragHandleWidth / 2;

  double panelDxOffset = 0.0;

  AnimationController? animationController;
  Animation<double>? _revealAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    _revealAnimation = Tween<double>(begin: panelDxOffset, end: panelWidth - panelWidthOffset - panelDxOffset)
        .animate(CurvedAnimation(parent: animationController!, curve: Curves.ease));
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void onDrag(DragUpdateDetails details) {
    if (panelDxOffset >= panelWidth - panelWidthOffset - 2.0) {
      panelDxOffset = panelWidth - panelWidthOffset - 2.0;
      return;
    }
    print(details.delta);
    final dx = details.localPosition.dx;
    panelDxOffset += 1.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: panelWidth,
      height: panelHeight,
      child: Stack(
        children: [
          Positioned(
            right: -panelDxOffset,
            width: panelWidth,
            height: panelHeight,
            child: ClipPath(
              clipper: SideToolsPanelClipper(panelWidthOffset, dragAreaHeight),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3.0,
                  sigmaY: 3.0,
                ),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
            ),
          ),
          Positioned(
            top: dragHandleTopPos,
            right: dragHandleRightPos - panelDxOffset,
            child: Container(
              child: GestureDetector(
                onHorizontalDragUpdate: onDrag,
                child: DragHandle(
                  color: Colors.black,
                  size: Size(dragHandleWidth, dragHandleHeight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SideToolsPanelClipper extends CustomClipper<Path> {
  final double widthOffset;
  final double dragAreaHeight;

  SideToolsPanelClipper(this.widthOffset, this.dragAreaHeight);

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final dragAreaTopPos =
        (ScreenResources.screenHeight - ScreenResources.appBarHeight - ScreenResources.bottomBatHeight - kToolbarHeight - dragAreaHeight) /
            2;
    final path = Path();
    path.moveTo(widthOffset, 0);
    path.lineTo(widthOffset, dragAreaTopPos);
    path.quadraticBezierTo(-widthOffset, dragAreaTopPos + dragAreaHeight / 2, widthOffset, dragAreaTopPos + dragAreaHeight);
    path.lineTo(widthOffset, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
