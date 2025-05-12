// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:nepatronix/model/theme_model.dart';

// class ThemeServices {
//   static const String _themeBoxName = 'theme_box';
//   static const String _themeKey = 'currrent_theme';

//   //Initialize Hive
//   static Future<void> init() async {
//     await Hive.initFlutter();
//     Hive.registerAdapter(ThemeModelAdapter());

//     //Open Box
//     await Hive.openBox<ThemeModel>(_themeBoxName);
//   }

// //Get theme box
//   static Box<ThemeModel> get _themeBox => Hive.box<ThemeModel>(_themeBoxName);

// //Save theme to hive
//   static Future<void> saveTheme(ThemeModel theme) async {
//     await _themeBox.put(_themeKey, theme);
//   }

//   // Get theme from Hive
//   static ThemeModel getTheme() {
//     return _themeBox.get(_themeKey) ?? ThemeModel(isDarkMode: false);
//   }
// }

import 'package:hive/hive.dart';
import 'package:nepatronix/model/theme_model.dart';

class ThemeServices {
  static const String boxName = 'themeBox';
  static const String key = 'themeModel';

  // Save theme to Hive
  static Future<void> saveTheme(ThemeModel themeModel) async {
    final box = await Hive.openBox(boxName);
    box.put(key, themeModel);
  }

  // Get theme from Hive or return default
  static ThemeModel getTheme() {
    try {
      final box = Hive.box(boxName);
      final themeModel = box.get(key);
      if (themeModel != null && themeModel is ThemeModel) {
        return themeModel;
      }
    } catch (e) {
      // Box might not be open yet, or other error
      try {
        // Try to open the box first
        final box = Hive.openBox(boxName);
        final themeModel = box.then((box) => box.get(key));
        if (themeModel != null && themeModel is ThemeModel) {
          return themeModel as ThemeModel;
        }
      } catch (_) {
        // Ignore error and return default
      }
    }

    // Return default theme model
    return ThemeModel(isDarkMode: false);
  }

  // Initialize Hive for theme storage
  static Future<void> init() async {
    // Make sure Hive is initialized (usually done in main.dart)
    // Hive.init(directory) should be called before this in your app initialization

    // Register the ThemeModel adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ThemeModelAdapter());
    }

    // Open the box
    await Hive.openBox(boxName);
  }
}
