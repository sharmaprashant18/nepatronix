// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';

// // class ProfileScreen extends StatelessWidget {
// //   const ProfileScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CircleAvatar(
// //               radius: 50,
// //               backgroundColor: Color(0xff5F73F3),
// //               child: Icon(CupertinoIcons.person, size: 60, color: Colors.white),
// //             ),
// //             SizedBox(height: 20),
// //             Text(
// //               'Nepa Tronix',
// //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 10),
// //             Text('Premium Member'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nepatronix/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  void closeApp() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.orange)),
          onPressed: () {
            // onpressed functionality
            // showAdaptiveDialog(
            //   useSafeArea: true,
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       title: Text('Are you sure you want to logout?'),
            //       content: ,
            //       alignment: Alignment.center,
            //     );
            //   },
            // );
          },
          label: Text(
            'Log Out',
            style: TextStyle(color: Colors.black),
          )),
      backgroundColor: AppColors.appBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(right: 2.w, left: 2.w, top: 4.h),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        //User image
                        ClipOval(
                          child: Image.asset(
                            'assets/nepatronix.jpg',
                            width: 25.w,
                            height: 25.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: -0.h,
                          right: -0.3.h,
                          child: Container(
                            height: 3.h,
                            width: 3.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                size: 2.h,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    //Name of the user
                    Text(
                      'NepaTronix',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {},
                        //Email of the user
                        child: Text(
                          'support@nepatronix.com',
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    profileInfo(
                        'Edit Profile',
                        Icon(Icons.manage_accounts_outlined),
                        'Edit Your Profile',
                        trailingIcon: Icon(Icons.arrow_forward_ios)),
                    profileInfo(
                        'Add Pin', Icon(Icons.lock_outline), 'Add your pin',
                        trailingIcon: Icon(Icons.arrow_forward_ios)),

                    profileInfo(
                        'Invite a friend',
                        Icon(Icons.group_add_outlined),
                        trailingIcon: Icon(Icons.arrow_forward_ios),
                        'Invite a friend'),

                    profileInfo(
                        'Settings', Icon(Icons.settings_outlined), 'Settings',
                        trailingIcon: Icon(Icons.arrow_forward_ios)),
                    profileInfo('Help & support', Icon(Icons.help_outline),
                        'Help and Support',
                        trailingIcon: Icon(Icons.arrow_forward_ios)),
                    profileInfo(
                        'Display & accessibility',
                        Icon(Icons.nightlight_outlined),
                        'Display and Accessibility',
                        trailingIcon: Icon(Icons.arrow_forward_ios)),
                    profileInfo('Give feedback', Icon(Icons.feedback_outlined),
                        'Your Feedback'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget profileInfo(String text, Icon leadingIcon, String details,
      {Icon? trailingIcon}) {
    return Card(
      color: Colors.white,
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16),
          collapsedIconColor: Colors.black,

          iconColor: Colors.black,
          textColor: Colors.black,
          collapsedTextColor: Colors.black,
          expandedAlignment: Alignment.centerRight,
          initiallyExpanded: false,
          // collapsedIconColor: Colors.black,
          title: Text(text),
          leading: leadingIcon,
          trailing: trailingIcon,
          showTrailingIcon: trailingIcon != null,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                details,
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
