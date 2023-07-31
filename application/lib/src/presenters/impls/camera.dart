import 'package:application/src/presenters/interfaces.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ICameraPresenter)
class CameraPresenterImpl extends ICameraPresenter {
  @override
  Widget uiBuilder() => const Scaffold(
        body: Center(child: Text('CAMERA SCREEN')),
      );
}
