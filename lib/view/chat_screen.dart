import 'package:flutter/material.dart';
import 'package:nepatronix/model/chat_model.dart';
import 'package:nepatronix/view/personal_chat.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String searchQuery = '';
  late List<UserModel> filteredUsers;
  @override
  void initState() {
    super.initState();
    filteredUsers = sampleUsers;
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredUsers = sampleUsers;
      } else {
        filteredUsers = sampleUsers
            .where((user) =>
                user.name.toLowerCase().contains(query.toLowerCase()) ||
                user.message.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5.h, right: 2.h, left: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top part
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Innovator',
                  style: TextStyle(
                      color: Colors.orange,
                      letterSpacing: 5.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Montserrat',
                      fontSize: 18.sp),
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/nepatronix.jpg',
                    fit: BoxFit.cover,
                    height: 3.2.h,
                    width: 3.2.h,
                  ),
                )
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  searchBar(),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'Active',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  SizedBox(
                    height: 12.h,
                    child: activeUsers(),
                  ),
                  Text(
                    'Messages',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  filteredUsers.isNotEmpty
                      ? message()
                      : Center(
                          child: Text('No Resuts Found'),
                        )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return SearchBar(
      onChanged: updateSearch,
      elevation: WidgetStatePropertyAll(0),
      constraints: BoxConstraints(
          minHeight: 5.h,
          maxHeight: 6.h,
          maxWidth: double.infinity,
          minWidth: double.infinity),
      backgroundColor: WidgetStatePropertyAll(Colors.white),
      leading: Icon(
        Icons.search,
        color: Colors.blueGrey,
      ),
      hintText: 'Search People',
      hintStyle: WidgetStatePropertyAll(TextStyle(
        color: Colors.blueGrey,
      )),
    );
  }

  Widget activeUsers() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      addAutomaticKeepAlives: true,
      itemCount: sampleUsers.length,
      itemBuilder: (context, index) {
        final user = sampleUsers[index];
        return Container(
          width: 17.w,
          margin: EdgeInsets.only(right: 2.w),
          child: Column(
            children: [
              Stack(
                children: [
                  // Colored background circle
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalChat(user: user),
                        )),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          user.image,
                          height: 15.w,
                          width: 15.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Green online indicator positioned at the bottom
                  if (user.isOnline)
                    Positioned(
                      bottom: 0,
                      left: 2.w,
                      child: Container(
                        height: 1.5.h,
                        width: 1.5.h,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 0.8.h,
              ),
              Flexible(
                child: Text(
                  user.name.split(' ').first,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget message() {
    return Column(
        children: filteredUsers.map((user) {
      DateTime messageTime = user.lastMessageTime;
      final now = DateTime.now();
      final difference = now.difference(messageTime);

      String trailingText;

      if (difference.inHours < 24) {
        // Show time like "3:45 PM"
        trailingText = DateFormat.jm().format(messageTime);
      } else {
        // Show date like "May 11"
        trailingText = DateFormat.MMMd().format(messageTime);
      }
      return Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalChat(
                      user: user,
                    ),
                  ));
            },
            onLongPress: () {
              //if long pressed in the tile then it pop up from the bottom
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Block'),
                          leading: Icon(
                            Icons.block,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          title: Text('Report'),
                          leading: Icon(
                            Icons.report_gmailerrorred,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  // title: Text('Delete Confirmation'),
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
                                          // Remove from both lists
                                          sampleUsers.remove(user);
                                          filteredUsers.remove(user);
                                        });
                                        Navigator.of(context)
                                            .pop(); // Close dialog
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
                            style: TextStyle(color: Colors.red),
                          ),
                          leading: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: AssetImage(user.image),
            ),
            title: Text(user.name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${user.message}.'),
                Text(
                  trailingText,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
        ],
      );
    }).toList());
  }
}
