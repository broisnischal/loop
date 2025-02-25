import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loop/core/constants/colors.dart';

ThemeData darkTheme = ThemeData.light(useMaterial3: true).copyWith(
  // colorScheme: ColorScheme.fromSeed(
  //   seedColor: ColorConst.blackColor,
  //   primary: ColorConst.blackColor,
  //   secondary: ColorConst.blackColor,
  //   tertiary: ColorConst.blackColor,
  // ),
  scaffoldBackgroundColor: ColorConst.whiteColor,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: ColorConst.whiteColor,
    actionsIconTheme: const IconThemeData(color: Colors.amber),

    // color: ColorConst.blackColor,
    titleTextStyle: const TextStyle(color: ColorConst.whiteColor),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.grey.shade100,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
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
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      color: ColorConst.whiteColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
);


// #222326 - nordic grey
// #F4F5F8 - mercury white
// #5E6AD2 - magic blue
// #F9F9F9 - white smoke
// #FFC107 - cool amber