import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nepatronix/auth_helper/appdata.dart';
import 'package:nepatronix/constants/app_colors.dart';
import 'package:nepatronix/provider/theme_provider.dart';
import 'package:nepatronix/services/theme_services.dart';
import 'package:nepatronix/view/chat_screen.dart';
import 'package:nepatronix/view/drawer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await ThemeServices.init();
  await DioClient.initialize();
  runApp(ProviderScope(child: Home()));

  OneSignal.initialize("com.example.nepatronix");

  // runApp(ProviderScope(
  //   child: DevicePreview(
  //     enabled: kDebugMode,
  //     builder: (context) => Home(),
  //   ),
  // ));
}

// class Home extends ConsumerWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //if want to enable the dark mode and light mode option
//     // final themeData = ref.watch(themeDataProvider);
//     return Sizer(builder: (context, orientation, screenType) {
//       return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           // home: Homepage(),
//           // home: DrawerPage(),
//           home: ChatScreen(),

//           // theme: themeData, //if want to enable the dark mode and light mode option
//           theme: ThemeData(
//             useMaterial3: true,
//             appBarTheme: AppBarTheme(
//               backgroundColor: AppColors.appBackground,
//             ),
//             scaffoldBackgroundColor: AppColors.appBackground,
//             dialogBackgroundColor: AppColors.appBackground,
//           )
//           // home: NewHomeScreen(),
//           // home: CoursesScreen(),
//           );
//     });
//   }
// }

class Home extends StatelessWidget {
  const Home({super.key});

  Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getToken();
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return FutureBuilder<bool>(
          future: isLoggedIn(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            }

            final loggedIn = snapshot.data!;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: ChatScreen(),
              theme: ThemeData(
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                  backgroundColor: AppColors.appBackground,
                ),
                scaffoldBackgroundColor: AppColors.appBackground,
                dialogBackgroundColor: AppColors.appBackground,
              ),
            );
          },
        );
      },
    );
  }
}
