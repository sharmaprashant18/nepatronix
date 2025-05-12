import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
                        fontWeight: FontWeight.bold,
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
                          height: 3.5.h,
                          width: 3.5.h,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              searchBar()
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
}
