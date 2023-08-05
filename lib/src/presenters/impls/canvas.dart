import 'package:flutter/material.dart';
import 'package:good_lib/good_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';
import 'package:ui/ui.dart';

@Injectable(as: ICanvasPresenter)
class CanvasPresenterImpl extends ICanvasPresenter {
  final screenController = GScreenController(initialState: CanvasDefault());

  @override
  Widget uiBuilder() => CanvasScreen(screenController: screenController);
}
