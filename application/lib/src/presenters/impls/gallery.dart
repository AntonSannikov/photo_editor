import 'package:application/src/presenters/interfaces.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IGalleryPresenter)
class GalleryPresenterImpl extends IGalleryPresenter {
  @override
  Widget uiBuilder() => const Scaffold(
        body: Center(child: Text('GALLERY SCREEN')),
      );
}
