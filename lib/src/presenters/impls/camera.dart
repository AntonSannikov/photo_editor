import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';

@Injectable(as: ICameraPresenter)
class CameraPresenterImpl extends ICameraPresenter {
  @override
  Widget uiBuilder() => const Scaffold(
        body: Center(child: Text('CAMERA SCREEN')),
      );
}
