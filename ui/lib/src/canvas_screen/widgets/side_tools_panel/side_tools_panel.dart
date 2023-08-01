import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui/src/canvas_screen/widgets/side_tools_panel/side_tools_panel_resources.dart';
import 'package:ui/src/canvas_screen/widgets/side_tools_panel/drag_handle.dart';

class SideToolsPanel extends StatefulWidget {
  const SideToolsPanel({Key? key}) : super(key: key);

  @override
  State<SideToolsPanel> createState() => _SideToolsPanelState();
}

typedef R = SideToolsPanelResources;

enum SidePanelState {
  opened,
  opening,
  closed,
  closing,
  animating,
}

class _SideToolsPanelState extends State<SideToolsPanel> with SingleTickerProviderStateMixin {
  double panelDxOffset = 0.0;
  SidePanelState panelState = SidePanelState.opened;

  AnimationController? animationController;
  Animation<double>? openCloseAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  void resetAnimatinController() {
    setPanelState(SidePanelState.animating);
    final panelDxOffsetM = panelDxOffset;
    animationController?.reset();
    panelDxOffset = panelDxOffsetM;
  }

  void animatePanelClosing() {
    resetAnimatinController();
    updateOpenCloseAnimation(Tween<double>(begin: panelDxOffset, end: R.closedPanelDxOffset));
    animationController?.forward().then((_) => setPanelState(SidePanelState.closed));
  }

  void animatePanelOpening() {
    resetAnimatinController();
    updateOpenCloseAnimation(Tween<double>(begin: panelDxOffset, end: 0.0));
    animationController?.forward().then((value) => setPanelState(SidePanelState.opened));
  }

  void updateOpenCloseAnimation(Tween<double> tween) {
    openCloseAnimation = tween.animate(CurvedAnimation(parent: animationController!, curve: Curves.ease))
      ..addListener(() => setState(() {
            panelDxOffset = openCloseAnimation!.value;
          }));
  }

  void setPanelState(SidePanelState state) => panelState = state;

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void onDragEnd(DragEndDetails _) {
    if (panelState == SidePanelState.closing) {
      animatePanelOpening();
    } else if (panelState == SidePanelState.opening) {
      animatePanelClosing();
    }
  }

  void onDrag(DragUpdateDetails details) {
    final direction = details.delta.dx.sign;

    if (direction == 1.0 && panelState == SidePanelState.closed ||
        direction == -1.0 && panelState == SidePanelState.opened ||
        panelState == SidePanelState.animating) {
      return;
    }
    if (direction == 1.0) {
      setPanelState(SidePanelState.closing);
      if (panelDxOffset >= R.panelDragAnimationDxOffsetBound) {
        animatePanelClosing();
      }
      if (panelDxOffset >= R.closedPanelDxOffset) {
        panelDxOffset = R.closedPanelDxOffset;
        setPanelState(SidePanelState.closed);
        return;
      }
    } else if (direction == -1.0) {
      panelState = SidePanelState.opening;
      if (R.closedPanelDxOffset - panelDxOffset >= R.panelDragAnimationDxOffsetBound) {
        animatePanelOpening();
      }
      if (panelDxOffset <= 0.0) {
        panelDxOffset = 0.0;
        setPanelState(SidePanelState.opened);
        return;
      }
    }
    panelDxOffset += direction * R.dragVelocity;
    setState(() {});
  }

  void onDragHandleTap() {
    if (panelState == SidePanelState.opened) {
      animatePanelClosing();
    } else if (panelState == SidePanelState.closed) {
      animatePanelOpening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: R.panelWidth,
      height: R.panelHeight,
      child: Stack(
        children: [
          Positioned(
            right: -panelDxOffset,
            width: R.panelWidth,
            height: R.panelHeight,
            child: ClipPath(
              clipper: SideToolsPanelClipper(
                widthOffset: R.panelWidthOffset,
                dragAreaHeight: R.dragAreaHeight,
                dragAreaTopPos: R.dragAreaTopPos,
              ),
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
            top: R.dragHandleTopPos,
            right: R.dragHandleRightPos - panelDxOffset,
            child: GestureDetector(
              onHorizontalDragUpdate: onDrag,
              onHorizontalDragEnd: onDragEnd,
              onTap: onDragHandleTap,
              child: DragHandle(
                color: Colors.grey.shade800,
                size: Size(R.dragHandleWidth, R.dragHandleHeight),
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
  final double dragAreaTopPos;

  SideToolsPanelClipper({
    required this.widthOffset,
    required this.dragAreaHeight,
    required this.dragAreaTopPos,
  });

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
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
