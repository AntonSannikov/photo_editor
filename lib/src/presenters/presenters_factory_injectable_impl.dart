import 'package:good_lib/good_lib.dart';
import 'package:photo_editor/src/di/injection.dart';
import 'package:photo_editor/src/presenters/impls/root.dart';

class AppPresentersGlobalState implements GPresentersGlobalState {}

class AppPresentersFactory extends GPresenterFactory<AppPresentersGlobalState> {
  @override
  GRootPresenter<GPresenterNavigationDelegate, GPresentersGlobalState> get rootPresenter => RootPresenter();

  @override
  I get<I extends GPresenter<Enum, GPresentersGlobalState>>() {
    final presenter = injection<I>();
    // switch (I) {
    //   default:
    // }
    return presenter;
  }
}
