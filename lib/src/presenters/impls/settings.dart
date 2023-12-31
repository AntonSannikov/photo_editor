import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';

@Injectable(as: ISettingsPresenter)
class SettingsPresenterImpl extends ISettingsPresenter {
  @override
  Widget uiBuilder() => const Scaffold(
        body: Center(child: Text('SETTINGS SCREEN')),
      );
}
