import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'theme_model.g.dart'; // This will be generated by Hive

@HiveType(typeId: 0)
class ThemeModel extends HiveObject {
  @HiveField(0)
  bool isDarkMode;

  ThemeModel({this.isDarkMode = false});

  // Get appropriate theme data (simplified to just black/white)
  // ThemeData get themeData {
  //   if (isDarkMode) {
  //     // Dark mode: white text on black background
  //     return ThemeData(
  //       brightness: Brightness.dark,
  //       // scaffoldBackgroundColor: Colors.black,
  //       scaffoldBackgroundColor: const Color(0xffEDF4FE),
  //       primaryColor: Colors.black,
  //       colorScheme: const ColorScheme.dark(
  //         surface: Colors.black,
  //         onSurface: Colors.white,
  //       ),
  //       textTheme: const TextTheme(
  //         bodyLarge: TextStyle(color: Colors.white),
  //         bodyMedium: TextStyle(color: Colors.white),
  //         bodySmall: TextStyle(color: Colors.white),
  //         titleLarge: TextStyle(color: Colors.white),
  //         titleMedium: TextStyle(color: Colors.white),
  //         titleSmall: TextStyle(color: Colors.white),
  //       ),
  //       appBarTheme: const AppBarTheme(
  //         backgroundColor: Colors.black,
  //         foregroundColor: Colors.white,
  //       ),
  //       cardTheme: const CardTheme(
  //         color: Colors.black,
  //       ),
  //       iconTheme: const IconThemeData(
  //         color: Colors.white,
  //       ),
  //     );
  //   } else {
  //     // Light mode: black text on white background
  //     return ThemeData(
  //       brightness: Brightness.light,
  //       scaffoldBackgroundColor: Colors.white,
  //       primaryColor: Colors.white,
  //       colorScheme: const ColorScheme.light(
  //         surface: Colors.white,
  //         onSurface: Colors.black,
  //       ),
  //       textTheme: const TextTheme(
  //         bodyLarge: TextStyle(color: Colors.black),
  //         bodyMedium: TextStyle(color: Colors.black),
  //         bodySmall: TextStyle(color: Colors.black),
  //         titleLarge: TextStyle(color: Colors.black),
  //         titleMedium: TextStyle(color: Colors.black),
  //         titleSmall: TextStyle(color: Colors.black),
  //       ),
  //       appBarTheme: const AppBarTheme(
  //         backgroundColor: Colors.white,
  //         foregroundColor: Colors.black,
  //       ),
  //       cardTheme: const CardTheme(
  //         color: Colors.white,
  //       ),
  //       iconTheme: const IconThemeData(
  //         color: Colors.black,
  //       ),
  //     );
  //   }
  // }
  ThemeData get themeData {
    if (isDarkMode) {
      // Dark mode: black background
      return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardTheme(
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      );
    } else {
      // Light mode: custom light background color
      return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xffEDF4FE), // ✅ Custom background
        primaryColor: const Color(0xffEDF4FE),
        colorScheme: const ColorScheme.light(
          surface: Color(0xffEDF4FE),
          onSurface: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffEDF4FE),
          foregroundColor: Colors.black,
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      );
    }
  }

  // Toggle theme
  void toggle() {
    isDarkMode = !isDarkMode;
    save(); // Save to Hive automatically
  }

  // Create a copy with modified values
  ThemeModel copyWith({bool? isDarkMode}) {
    return ThemeModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
