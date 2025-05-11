import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/view/drawer.dart';

import 'package:nepatronix/view/homepage.dart';
import 'package:nepatronix/view/new_home_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  // runApp(ProviderScope(child: Home()));
  runApp(ProviderScope(
    child: DevicePreview(
      enabled: kDebugMode,
      builder: (context) => Home(),
    ),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Homepage(),
        home: DrawerPage(),
        // home: NewHomeScreen(),
        // home: CoursesScreen(),
      );
    });
  }
}
