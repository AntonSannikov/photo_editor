import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';

class HomeScreen extends GScreen {
  final Widget navigationWidget;
  final VoidCallback onCameraButtonTap$;
  final VoidCallback onGalleryButtonTap$;
  final void Function(int index) onBottomBarTap$;
  final ValueListenable<String> $appBarTitle;
  final ValueListenable<int> $tabIndex;

  const HomeScreen({
    super.key,
    required super.screenController,
    required this.navigationWidget,
    required this.onCameraButtonTap$,
    required this.onGalleryButtonTap$,
    required this.onBottomBarTap$,
    required this.$appBarTitle,
    required this.$tabIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends GScreenState<HomeScreen, Object> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: widget.$appBarTitle,
            builder: (_, String title, __) {
              return Text(title);
            }),
        actions: [
          IconButton(onPressed: widget.onCameraButtonTap$, icon: const Icon(Icons.photo_camera)),
          IconButton(onPressed: widget.onGalleryButtonTap$, icon: const Icon(Icons.photo_album)),
        ],
      ),
      body: widget.navigationWidget,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: widget.$tabIndex,
          builder: (_, int i, __) {
            return NavigationBar(
              selectedIndex: i,
              onDestinationSelected: widget.onBottomBarTap$,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.list), label: 'canvas'),
                NavigationDestination(icon: Icon(Icons.add), label: 'settings'),
              ],
            );
          }),
    );
  }
}
