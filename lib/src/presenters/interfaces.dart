import 'package:good_lib/good_lib.dart';
import 'package:photo_editor/src/presenters/presenters_factory_injectable_impl.dart';

enum SplashState { initialized }

enum HomeState { showCanvasTab, showSettingsTab, openGallery, openCamera }

abstract class ISplashPresenter extends GPresenter<SplashState, AppPresentersGlobalState> {}

abstract class IGalleryPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}

abstract class IHomePresenter extends GShellPresenter<HomeState, AppPresentersGlobalState> {}

abstract class ICanvasPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}

abstract class ISettingsPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}

abstract class ICameraPresenter extends GPresenter<Enum, AppPresentersGlobalState> {}
