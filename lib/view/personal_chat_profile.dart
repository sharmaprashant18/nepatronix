import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/model/chat_model.dart';
import 'package:nepatronix/view/chat_screen.dart';

import 'package:sizer/sizer.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key, required this.user});
  final UserModel user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  final TextEditingController _nicknameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                    'Are you sure you want to delete this message?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          sampleUsers.remove(widget.user);
                                        });
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatScreen(),
                                            )); // Close dialog
                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          title: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ),
                        ListTile(
                          trailing: IconButton(
                              onPressed: () {}, icon: Icon(Icons.report)),
                          title: Text('Report User'),
                        )
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(right: 3.w, left: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            widget.user.image,
                            fit: BoxFit.cover,
                            height: 8.h,
                            width: 8.h,
                          ),
                        ),
                        if (widget.user.isOnline)
                          Positioned(
                            bottom: 0.7.h,
                            right: 0.5.h,
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
                    Text(widget.user.nickname ?? widget.user.name,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Customization',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(
                height: 1.h,
              ),
              listTileItem(
                  text: 'Nickname',
                  onTap: () {
                    _nicknameController.text =
                        widget.user.nickname ?? widget.user.name;
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: TextFormField(
                                controller: _nicknameController,
                                enabled: true,
                                decoration: InputDecoration(
                                    hintText: widget.user.nickname ??
                                        widget.user.name,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange))),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.orange)),
                                onPressed: () {
                                  final newNickname =
                                      _nicknameController.text.trim();
                                  if (newNickname.isNotEmpty) {
                                    setState(() {
                                      widget.user.nickname = newNickname;
                                    });
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'))
                          ],
                        );
                      },
                    );
                  }),
              SizedBox(
                height: 3.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy and Support',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                  TextButton.icon(
                      icon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                'Are you sure you want to delete this message?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sampleUsers.remove(widget.user);
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(),
                                        )); // Close dialog
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listTileItem(
      {required String text,
      VoidCallback? onTap,
      TextStyle? style,
      IconButton? icon}) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: icon,
      title: Text(
        text,
        style: style,
      ),
      onTap: onTap,
    );
  }
}
