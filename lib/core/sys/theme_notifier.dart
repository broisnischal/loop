// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loop/core/themes/theme.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeCubit extends Cubit<ThemeData> {
//   ThemeCubit() : super(appThemeData[AppThemeType.light]!) {
//     _loadTheme();
//   }

//   // Load theme preference from SharedPreferences
//   Future<void> _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedTheme = prefs.getString('theme') ?? 'system';
//     if (savedTheme == 'dark') {
//       emit(appThemeData[AppThemeType.dark]!);
//     } else if (savedTheme == 'light') {
//       emit(appThemeData[AppThemeType.light]!);
//     } else {
//       // If it's 'system', use system brightness
//       final brightness = WidgetsBinding.instance.window.platformBrightness;
//       emit(
//         brightness == Brightness.dark
//             ? appThemeData[AppThemeType.dark]!
//             : appThemeData[AppThemeType.light]!,
//       );
//     }
//   }

//   // Change the theme and store it
//   Future<void> changeTheme(AppThemeType type) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('theme', type.name);
//     emit(appThemeData[type]!);
//   }
// }
