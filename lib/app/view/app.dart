import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loop/core/sys/theme_notifier.dart';
import 'package:loop/core/themes/theme.dart';
import 'package:loop/di/injection_config.dart';
import 'package:loop/l10n/l10n.dart';
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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        theme: appThemeData[AppThemeType.light],
        darkTheme: appThemeData[AppThemeType.dark],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: mainRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
      // child: BlocProvider<ThemeCubit>(
      //   create: (_) => ThemeCubit(),
      //   child: BlocBuilder<ThemeCubit, ThemeData>(
      //     builder: (context, themeData) {
      //       return
      //     },
      //   ),
      // ),
    );
  }
}
