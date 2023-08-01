import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';

class HomeScreen extends GScreen {
  final Widget navigationWidget;
  final VoidCallback onCameraButtonTap;
  final VoidCallback onGalleryButtonTap;
  final void Function(int index) onBottomBarTap;
  final String appBarTitle;
  final int tabIndex;

  HomeScreen({
    super.key,
    required this.navigationWidget,
    required this.onCameraButtonTap,
    required this.onGalleryButtonTap,
    required this.onBottomBarTap,
    required this.appBarTitle,
    required this.tabIndex,
    required super.$screenCondition,
    super.onLifecycleStateChange$,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends GScreenState<HomeScreen, Object> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          IconButton(onPressed: widget.onCameraButtonTap, icon: const Icon(Icons.photo_camera)),
          IconButton(onPressed: widget.onGalleryButtonTap, icon: const Icon(Icons.photo_album)),
        ],
      ),
      body: widget.navigationWidget,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.tabIndex,
        onDestinationSelected: widget.onBottomBarTap,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'canvas'),
          NavigationDestination(icon: Icon(Icons.add), label: 'settings'),
        ],
      ),
    );
  }
}
