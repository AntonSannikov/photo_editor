import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:ui/src/canvas_screen/resources.dart';
import 'package:ui/src/canvas_screen/widgets/side_tools_panel/drag_handle.dart';
import 'package:ui/src/canvas_screen/widgets/side_tools_panel/tool_button.dart';

class SideToolsPanel extends StatefulWidget {
  const SideToolsPanel({Key? key}) : super(key: key);

  @override
  State<SideToolsPanel> createState() => _SideToolsPanelState();
}

enum SidePanelToolButtonId {
  bars,
  fullscreen,
  brightness,
  constants,
  exposure,
  mono,
}

enum SidePanelState {
  opened,
  opening,
  closed,
  closing,
  animating,
}

class _SideToolsPanelState extends State<SideToolsPanel>
    with WidgetResourcesMixin<SideToolsPanel, SideToolsPanelResources>, SingleTickerProviderStateMixin {
  double panelDxOffset = 0.0;
  SidePanelState panelState = SidePanelState.opened;

  AnimationController? animationController;
  Animation<double>? openCloseAnimation;

  @override
  void initState() {
    super.initState();
    registerResources(SideToolsPanelResources());
    if (panelState == SidePanelState.closed) {
      panelDxOffset = r.closedPanelOffset;
    }
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void resetAnimatinController() {
    setPanelState(SidePanelState.animating);
    final panelDxOffsetM = panelDxOffset;
    animationController?.reset();
    panelDxOffset = panelDxOffsetM;
  }

  void animatePanelClosing() {
    resetAnimatinController();
    updateOpenCloseAnimation(Tween<double>(begin: panelDxOffset, end: r.closedPanelOffset));
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
      if (panelDxOffset >= r.panelDragAnimationOffsetTrigger) {
        return animatePanelClosing();
      }
      if (panelDxOffset >= r.closedPanelOffset) {
        panelDxOffset = r.closedPanelOffset;
        setPanelState(SidePanelState.closed);
        return;
      }
    } else if (direction == -1.0) {
      panelState = SidePanelState.opening;
      if (r.closedPanelOffset - panelDxOffset >= r.panelDragAnimationOffsetTrigger) {
        animatePanelOpening();
      }
      if (panelDxOffset <= 0.0) {
        panelDxOffset = 0.0;
        setPanelState(SidePanelState.opened);
        return;
      }
    }
    panelDxOffset += direction * r.dragVelocity;
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
    return Positioned(
      right: -panelDxOffset,
      width: r.panelSize.width,
      height: r.panelSize.height,
      child: ClipPath(
        clipper: SideToolsPanelClipper(
          widthOffset: r.panelClipWidth,
          dragAreaHeight: r.dragAreaHeight,
          dragAreaTopPos: r.dragAreaTopPos,
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 3.0,
                sigmaY: 3.0,
              ),
              child: Container(
                alignment: Alignment.topRight,
                color: Colors.black.withOpacity(0.2),
                child: SizedBox(
                    width: r.toolsAreaSize.width,
                    height: r.toolsAreaSize.height,
                    child: SidePanelToolButtonList(
                      iconSize: r.toolsAreaSize.width / 2,
                      splashRadius: 30.0,
                      rippleShaderAsset: r.rippleShaderAsset,
                      items: [
                        SidePanelToolButtonModel(
                          id: SidePanelToolButtonId.bars,
                          icon: Icons.open_in_full_rounded,
                        ),
                        SidePanelToolButtonModel(
                          id: SidePanelToolButtonId.fullscreen,
                          icon: Icons.aspect_ratio_sharp,
                        ),
                        SidePanelToolButtonModel(
                          id: SidePanelToolButtonId.brightness,
                          icon: Icons.brightness_3_outlined,
                        ),
                        SidePanelToolButtonModel(
                          id: SidePanelToolButtonId.constants,
                          icon: Icons.contrast,
                        ),
                        SidePanelToolButtonModel(
                          id: SidePanelToolButtonId.exposure,
                          icon: Icons.exposure,
                        ),
                        SidePanelToolButtonModel(
                          id: SidePanelToolButtonId.mono,
                          icon: Icons.monochrome_photos,
                        ),
                      ],
                    )),
              ),
            ),
            Positioned(
              top: r.dragHandleTopPos,
              right: r.dragHandleRightPos,
              child: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onHorizontalDragUpdate: onDrag,
                onHorizontalDragEnd: onDragEnd,
                onTap: onDragHandleTap,
                child: DragHandle(
                  color: Colors.grey.shade800,
                  size: Size(r.dragHandleSize.width, r.dragHandleSize.height),
                ),
              ),
            ),
          ],
        ),
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
