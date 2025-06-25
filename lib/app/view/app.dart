import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loop/di/injection_config.dart';
import 'package:loop/l10n/arb/app_localizations.dart';
import 'package:loop/router/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final mainRouter = AppRouter();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Colors.black,
            actionsIconTheme: IconThemeData(color: Colors.amber),
            elevation: 0,
          ),
          useMaterial3: true,
        ), // multiple themes options
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // home: const HomeScreen(),
        routerConfig: mainRouter.config(
          deepLinkBuilder: (deepLink) {
            if (deepLink.path.startsWith('/deeplink')) {
              // Enter the path you created for the deep link.
              return deepLink;
            } else {
              return DeepLink.defaultPath;
              // or DeepLink.path('/')
              // or DeepLink([HomeRoute()])
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  @override
  void initState() {
    // Add the router as a dependency
    getIt
      ..registerSingletonAsync<AppRouter>(() async {
        return mainRouter;
      })
      ..registerSingletonAsync<GlobalKey<NavigatorState>>(() async {
        return _navigatorKey;
      });

    super.initState();
  }
}
