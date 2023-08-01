import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';
import 'package:ui/ui.dart';

@Injectable(as: ICanvasPresenter)
class CanvasPresenterImpl extends ICanvasPresenter {
  final ValueNotifier<CanvasScreenCondition> $screenCondition = ValueNotifier(CanvasDefault());
  @override
  void onStart() {
    setState((_) => _.$homeAppBarTitle.value = 'canvas');
  }

  @override
  Widget uiBuilder() => CanvasScreen($screenCondition: $screenCondition);
}
