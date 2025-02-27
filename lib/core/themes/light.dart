import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loop/core/constants/colors.dart';

ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorConst.blackColor,
    primary: ColorConst.blackColor,
    secondary: ColorConst.blackColor,
    tertiary: ColorConst.blackColor,
  ),
  scaffoldBackgroundColor: ColorConst.whiteColor,
  appBarTheme: AppBarTheme(
    backgroundColor: ColorConst.whiteColor,
    // color: ColorConst.blackColor,
    actionsIconTheme: const IconThemeData(color: Colors.amber),
    titleTextStyle: const TextStyle(color: ColorConst.blackColor),
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.dark,
    //   statusBarBrightness: Brightness.light,
    //   systemNavigationBarColor: Colors.grey.shade100,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ),
  ),
  splashColor: ColorConst.blackColor.withOpacity(0.1),
  tabBarTheme: TabBarTheme(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return ColorConst.blackColor
              .withOpacity(0.2); // Adjust opacity as needed
        }
        return null; // Defer to the widget's default
      },
    ),
  ),
  cardColor: ColorConst.whiteColor,
  cardTheme: CardTheme(
    color: ColorConst.whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 0,
    clipBehavior: Clip.hardEdge,
    shadowColor: ColorConst.blackColor.withOpacity(0.1),
    surfaceTintColor: ColorConst.whiteColor,
  ),
);
