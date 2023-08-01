import 'package:good_lib/good_lib.dart';
import 'package:photo_editor/src/di/injection.dart';
import 'package:photo_editor/src/presenters/global_state_impl.dart';
import 'package:photo_editor/src/presenters/impls/root.dart';
import 'package:photo_editor/src/presenters/interfaces.dart';

class AppPresentersFactory extends GPresenterFactory<AppPresentersGlobalState> {
  @override
  GRootPresenter<GPresenterNavigationDelegate, GPresentersGlobalState> get rootPresenter => RootPresenter();

  @override
  I get<I extends GPresenter<Enum, GPresentersGlobalState>>() {
    final presenter = injection<I>();
    switch (I) {
      case IHomePresenter:
        (presenter as IHomePresenter).$appBarTitle = presentersState.$homeAppBarTitle;
        break;
      default:
    }
    return presenter;
  }
}
