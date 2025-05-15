import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/constants/app_colors.dart';
import 'package:nepatronix/provider/theme_provider.dart';
import 'package:nepatronix/view/course.dart';
import 'package:nepatronix/view/faq.dart';
import 'package:nepatronix/view/new_home_screen.dart';
import 'package:nepatronix/view/privacy_policy.dart';
import 'package:nepatronix/view/profile_screen.dart';
import 'package:nepatronix/view/settings.dart';
import 'package:nepatronix/view/subscription.dart';
import 'package:nepatronix/view/support.dart';

class DrawerPage extends ConsumerWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Drawer'),
      ),
      drawer: Drawer(
        //if the backgroud color of the drawer needs to be changed can be use any color by default the color is white

        // backgroundColor: Color(0xffEDF4FE),
        // backgroundColor: Colors.deepOrangeAccent.shade100,
        // backgroundColor: Color(0xffFFBB9A),
        // backgroundColor: Colors.blue.shade100,

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              // color: Colors.deepOrangeAccent.shade100,
              color: Color(0xffFD9122),
              // color: Colors.blue.shade100,
              padding: EdgeInsets.only(top: 50, bottom: 20),
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.orangeAccent,
                child: ClipOval(
                  child: Image.asset(
                    'assets/nepatronix.jpg',
                    fit: BoxFit.contain,
                    width: 110,
                    height: 110,
                  ),
                ),
              ),
            ),
            // Divider(
            //   color: Colors.grey[300],
            //   thickness: 1,
            // ),
            SizedBox(
              height: 10,
            ),
            _drawer(
                context,
                0,
                'Home',
                Icon(
                  Icons.home,
                  color: Color(0xff5F73F3),
                  size: 25,
                )),
            _drawer(
                context,
                6,
                'Profile',
                Icon(
                  Icons.person,
                  color: Color(0xff5F73F3),
                  size: 25,
                )),
            _drawer(
                context,
                5,
                'Course',
                Icon(
                  Icons.play_lesson,
                  color: Color(0xff5F73F3),
                  size: 25,
                )),
            _drawer(
                context,
                4,
                'Support',
                Icon(
                  Icons.support_agent,
                  color: Color(0xff5F73F3),
                  size: 25,
                )),
            _drawer(
                context,
                3,
                'Subscription',
                Icon(
                  Icons.subscriptions,
                  size: 25,
                  color: Color(0xff5F73F3),
                )),
            _drawer(
                context,
                7,
                'Privacy Policy',
                Icon(
                  Icons.privacy_tip,
                  color: Color(0xff5F73F3),
                  size: 25,
                )),
            _drawer(
                context,
                2,
                'FAQ',
                Icon(
                  Icons.help,
                  size: 25,
                  color: Color(0xff5F73F3),
                )),
            _drawer(
                context,
                1,
                'Settings',
                Icon(
                  Icons.settings,
                  color: Color(0xff5F73F3),
                  size: 25,
                )),
            // Modified theme toggle with label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                color: AppColors.background,
                margin: EdgeInsets.zero,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Toggle icon
                      Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: Color(0xff5F73F3),
                        size: 25,
                      ),
                      // Mode label
                      Text(
                        isDarkMode ? 'Dark Mode' : 'Light Mode',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Switch
                      Switch(
                        value: isDarkMode,
                        activeColor: const Color(0xff5F73F3),
                        onChanged: (value) {
                          // Toggle theme using our provider
                          ref.read(themeProvider.notifier).setDarkMode(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawer(BuildContext context, int id, String title, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: AppColors.background,
        margin: EdgeInsets.zero,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 6),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                switch (id) {
                  case 0:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                    break;
                }
                switch (id) {
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                    break;
                }
                switch (id) {
                  case 2:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FAQScreen()));
                    break;
                }
                switch (id) {
                  case 3:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Subscription()));
                    break;
                }
                switch (id) {
                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupportScreen()));
                    break;
                }
                switch (id) {
                  case 5:
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseScreen()));
                    break;
                }
                switch (id) {
                  case 6:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                    break;
                }
                switch (id) {
                  case 7:
                    // launchUrl(Uri.parse('https://nepatronix.org/about'));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()));

                    break;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  icon,
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
