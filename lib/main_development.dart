import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:loop/app/view/app.dart';
import 'package:loop/bootstrap.dart';
import 'package:loop/core/sys/environment.dart';
import 'package:loop/di/injection_config.dart';

void main() async {
  // bootstrap(() => const App());
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DartPluginRegistrant.ensureInitialized();

      // await Firebase.initializeApp(
      //   name: 'vms_client_dev',
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );

      FlutterError.onError = (FlutterErrorDetails details) {
        // developer.log(
        //   'Flutter Error: ${details.exceptionAsString()}',
        //   name: 'FlutterError',
        //   level: 1000,
        //   // stackTrace: details.stack,
        // );

        // developer.log('Error: ${details.exception}', stackTrace: details.stack);

        // Report error to Firebase Crashlytics
        // FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      // PlatformDispatcher.instance.onError = (error, stack) {
      //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      //   return true;
      // };

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      Bloc.observer = const AppBlocObserver();

      // AppService().startService();
      const flavor =
          String.fromEnvironment('flavor', defaultValue: 'development');

      log('Flavor: $flavor');

      configureDependencies(Flavor.values.byName(flavor));

      // await FirebaseApi().init();

      // await initBackgroundService();

      try {
        await FlutterDisplayMode.setHighRefreshRate();
      } catch (e) {
        log(e.toString());
      }

      runApp(App());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
