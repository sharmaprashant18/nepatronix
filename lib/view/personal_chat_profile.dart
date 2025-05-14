import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/model/chat_model.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        user.image,
                        fit: BoxFit.cover,
                        height: 8.h,
                        width: 8.h,
                      ),
                    ),
                    if (user.isOnline)
                      Positioned(
                        bottom: 1.h,
                        right: 1.h,
                        child: Container(
                          height: 1.5.h,
                          width: 1.5.h,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(user.name),
            ],
          ),
        ),
      ),
    );
  }
}
