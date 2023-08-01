import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';

@Injectable(as: IGalleryPresenter)
class GalleryPresenterImpl extends IGalleryPresenter {
  @override
  Widget uiBuilder() => const Scaffold(
        body: Center(child: Text('GALLERY SCREEN')),
      );
}
