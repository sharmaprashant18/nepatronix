import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/model/theme_model.dart';
import 'package:nepatronix/services/theme_services.dart';

class ThemeNotifier extends StateNotifier<ThemeModel> {
  ThemeNotifier() : super(ThemeServices.getTheme());
  void toggleTheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);

    //Save to Hive
    ThemeServices.saveTheme(state);
  }

  //Set Specific theme
  void setDarkMode(bool isDarkMode) {
    if (state.isDarkMode != isDarkMode) {
      state = state.copyWith(isDarkMode: isDarkMode);
      ThemeServices.saveTheme(state);
    }
  }

  //Get current Theme data
  ThemeData get themeData => state.themeData;
}

//theme provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeModel>((ref) {
  return ThemeNotifier();
});

// Theme data provider
final themeDataProvider = Provider<ThemeData>((ref) {
  final themeModel = ref.watch(themeProvider);
  return themeModel.themeData;
});

// Boolean isDarkMode provider (for convenience)
final isDarkModeProvider = Provider<bool>((ref) {
  final themeModel = ref.watch(themeProvider);
  return themeModel.isDarkMode;
});
