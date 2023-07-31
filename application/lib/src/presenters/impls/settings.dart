import 'package:application/src/presenters/interfaces.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ISettingsPresenter)
class SettingsPresenterImpl extends ISettingsPresenter {
  @override
  void onStart() {
    setState((_) => _.$homeAppBarTitle.value = 'settings');
  }

  @override
  Widget uiBuilder() => const Scaffold(
        body: Center(child: Text('SETTINGS SCREEN')),
      );
}
