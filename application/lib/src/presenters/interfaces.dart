import 'package:application/src/entrypoint.dart';
import 'package:application/src/presenters/global_state_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:good_lib/good_lib.dart';

final defaultConditionNotifier = ValueNotifier(Object());

abstract class ISplashPresenter extends GPresenter<SplashState, AppPresentersGlobalState> {}

abstract class IGalleryPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}

abstract class IHomePresenter extends GShellPresenter<HomeState, AppPresentersGlobalState> {
  abstract ValueListenable<String> $appBarTitle;
}

abstract class ICanvasPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}

abstract class ISettingsPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}

abstract class ICameraPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}
