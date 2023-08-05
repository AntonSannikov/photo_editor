import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';

enum SplashScreenState { loading, loaded }

class SplashScreen extends GScreen<SplashScreenState> {
  const SplashScreen({required super.screenController, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends GScreenState<SplashScreen, SplashScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade700,
      body: const Center(child: Text('Splash SCREEN')),
    );
  }
}
