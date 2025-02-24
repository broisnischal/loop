import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:loop/core/sys/environment.dart';
import 'package:loop/di/injection_config.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies(Flavor flavor) {
  log('Flavor: ${flavor.name}');
  $initGetIt(
    getIt,
    environment: flavor.name,
  ); // Must match @Environment() values
}
