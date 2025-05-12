import 'package:flutter/material.dart';
import 'package:nepatronix/model/chat_model.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 3.h, right: 2.h, left: 2.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
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
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                      SizedBox(
                        width: 5.w,
                      ),
                      ClipOval(
                        child: Image.asset(
                          'assets/nepatronix.jpg',
                          fit: BoxFit.cover,
                          height: 3.2.h,
                          width: 3.2.h,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              searchBar(),
              SizedBox(
                height: 4.h,
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
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Messages',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2.h,
              ),
              message()
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return SearchBar(
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
          width: 22.w,
          margin: EdgeInsets.only(right: 2.w),
          child: Column(
            children: [
              Stack(
                children: [
                  // Colored background circle
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        user.image,
                        height: 14.w,
                        width: 14.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Green online indicator positioned at the bottom
                  if (user.isOnline)
                    Positioned(
                      bottom: 0,
                      left: 1.5.w,
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
                  user.name,
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
      children: sampleUsers.map((user) {
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
        return ListTile(
          contentPadding: EdgeInsets.all(9),
          // horizontalTitleGap: 3,
          leading: CircleAvatar(
            backgroundImage: AssetImage(user.image),
          ),
          title: Row(
            children: [
              Text(user.name),
              SizedBox(
                width: 2.w,
              ),
              Icon(
                Icons.circle,
                color: user.isOnline ? Colors.green : Colors.grey,
                size: 10,
              ),
            ],
          ),
          subtitle: Text(user.message),
          trailing: Text(trailingText),
        );
      }).toList(),
    );
  }
}
