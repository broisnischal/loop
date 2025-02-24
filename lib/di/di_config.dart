// // di.config.dart
// import 'package:injectable/injectable.dart'
//     hide Environment; // Hide injectable's Environment
// import 'package:loop/core/sys/environment.dart'; // Your custom Environment
// import 'package:loop/core/sys/flavor.dart';

// @module
// abstract class AppModule {
//   @FlavorConfig(
//     Flavor.development,
//   ) // Now clearly refers to your custom annotation
//   @singleton
//   Environment get devEnv =>
//       DevEnvironment(); // Clearly refers to your Environment cla ss

//   // @FlavorConfig(Flavor.staging)
//   // @singleton
//   // Environment get stagingEnv => StagingEnvironment();

//   // @FlavorConfig(Flavor.production)
//   // @singleton
//   // Environment get prodEnv => ProdEnvironment();
// }

// di.config.dart
// REMOVE THIS ENTIRE BLOCK
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {}
