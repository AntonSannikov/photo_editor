import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_editor/src/di/injection.config.dart';

final injection = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies([String? environment]) => $initGetIt(injection, environment: environment);
