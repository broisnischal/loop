import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Animation durations
  static const Duration fast = Duration(milliseconds: 300);
  static const Duration normal = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 700);

  // Curves
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve reverseCurve = Curves.easeInCubic;

  // Category colors
  static const Map<String, Color> categoryColors = {
    'health': Color(0xFF4CAF50), // Green
    'productivity': Color(0xFF2196F3), // Blue
    'fitness': Color(0xFFFF5722), // Orange
    'mindfulness': Color(0xFF9C27B0), // Purple
    'learning': Color(0xFFFFEB3B), // Yellow
    'social': Color(0xFFE91E63), // Pink
    'finance': Color(0xFF00BCD4), // Teal
    'other': Color(0xFF9E9E9E), // Grey
  };
}

// Minimalist light theme (mostly black and white with subtle accents)
ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Colors.black, // Pure black
        onPrimary: Colors.white, // Pure white
        secondary: Color(0xFF424242), // Dark grey
        onSecondary: Colors.white, // Pure white
        tertiary: Color(0xFF757575), // Medium grey
        onTertiary: Colors.white, // Pure white
        error: Color(0xFFE53935), // Red (one of the few colors)
        onError: Colors.white, // Pure white
        background: Colors.white, // Pure white
        onBackground: Colors.black, // Pure black
        surface: Colors.white, // Pure white
        onSurface: Colors.black, // Pure black
        outline: Color(0xFFE0E0E0), // Very light grey
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        // backgroundColor: Colors.black,
        // foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 16),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xFF9E9E9E),
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFF9E9E9E),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Color(0xFF9E9E9E)),
        selectedLabelTextStyle: TextStyle(color: Colors.black),
        unselectedLabelTextStyle: TextStyle(color: Color(0xFF9E9E9E)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF5F5F5),
        disabledColor: const Color(0xFFEEEEEE),
        selectedColor: Colors.black,
        secondarySelectedColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        labelStyle: const TextStyle(color: Colors.black),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 57.0,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.black,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 45.0,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.black,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 36.0,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.black,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          color: Colors.black,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 28.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: Colors.black,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: Colors.black,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: Colors.black,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: Colors.black,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: Colors.black,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: Colors.black,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: Colors.black,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.black,
        linearTrackColor: Color(0xFFEEEEEE),
        circularTrackColor: Color(0xFFEEEEEE),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.black,
        inactiveTrackColor: const Color(0xFFE0E0E0),
        thumbColor: Colors.black,
        overlayColor: Colors.black.withOpacity(0.12),
        valueIndicatorColor: Colors.black,
        valueIndicatorTextStyle: const TextStyle(color: Colors.white),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.black;
            }
            return Colors.transparent;
          },
        ),
        checkColor: MaterialStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: Color(0xFF757575), width: 1.5),
      ),
    );

// Minimalist dark theme (mostly black and white with subtle accents)
ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white, // Pure white
        onPrimary: Colors.black, // Pure black
        secondary: Color(0xFFE0E0E0), // Light grey
        onSecondary: Colors.black, // Pure black
        tertiary: Color(0xFFBDBDBD), // Medium grey
        onTertiary: Colors.black, // Pure black
        error: Color(0xFFEF9A9A), // Light red
        onError: Colors.black, // Pure black
        background: Colors.black, // Pure black
        onBackground: Colors.white, // Pure white
        surface: Color(0xFF121212), // Very dark grey
        onSurface: Colors.white, // Pure white
        outline: Color(0xFF424242), // Dark grey
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xFF121212),
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 16),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF212121),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF9A9A), width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xFF757575),
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF757575),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: Color(0xFF757575)),
        selectedLabelTextStyle: TextStyle(color: Colors.white),
        unselectedLabelTextStyle: TextStyle(color: Color(0xFF757575)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF212121),
        disabledColor: const Color(0xFF121212),
        selectedColor: Colors.white,
        secondarySelectedColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        labelStyle: const TextStyle(color: Colors.white),
        secondaryLabelStyle: const TextStyle(color: Colors.black),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 57.0,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 45.0,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 36.0,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 28.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: Colors.white,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: Colors.white,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
        linearTrackColor: Color(0xFF424242),
        circularTrackColor: Color(0xFF424242),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.white,
        inactiveTrackColor: const Color(0xFF424242),
        thumbColor: Colors.white,
        overlayColor: Colors.white.withOpacity(0.12),
        valueIndicatorColor: Colors.white,
        valueIndicatorTextStyle: const TextStyle(color: Colors.black),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return Colors.transparent;
          },
        ),
        checkColor: MaterialStateProperty.all(Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: Color(0xFFBDBDBD), width: 1.5),
      ),
    );
