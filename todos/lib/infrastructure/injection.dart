import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todos/infrastructure/injection.config.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  generateForDir: ['lib', 'test'],
  usesNullSafety: true,
)
configureDependencies(String env) => injector.init(environment: env);
