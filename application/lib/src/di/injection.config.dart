// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../presenters/impls/camera.dart' as _i4;
import '../presenters/impls/canvas.dart' as _i5;
import '../presenters/impls/gallery.dart' as _i6;
import '../presenters/impls/home.dart' as _i7;
import '../presenters/impls/settings.dart' as _i8;
import '../presenters/impls/splash.dart' as _i9;
import '../presenters/interfaces.dart' as _i3;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ICameraPresenter>(() => _i4.CameraPresenterImpl());
  gh.factory<_i3.ICanvasPresenter>(() => _i5.CanvasPresenterImpl());
  gh.factory<_i3.IGalleryPresenter>(() => _i6.GalleryPresenterImpl());
  gh.factory<_i3.IHomePresenter>(() => _i7.HomePresenterImpl());
  gh.factory<_i3.ISettingsPresenter>(() => _i8.SettingsPresenterImpl());
  gh.factory<_i3.ISplashPresenter>(() => _i9.SplashPresenterImpl());
  return getIt;
}
