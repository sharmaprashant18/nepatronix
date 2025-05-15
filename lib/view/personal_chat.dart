import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nepatronix/provider/chat_message.dart';
import 'package:nepatronix/model/chat_model.dart';
import 'package:nepatronix/view/personal_chat_profile.dart';
import 'package:sizer/sizer.dart';

class PersonalChat extends ConsumerStatefulWidget {
  const PersonalChat({super.key, required this.user});
  final UserModel user;

  @override
  ConsumerState<PersonalChat> createState() => _PersonalChatState();
}

class _PersonalChatState extends ConsumerState<PersonalChat> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    // Cancel any pending animations before disposing controllers
    if (scrollController.hasClients) {
      scrollController.position.hold(() {});
    }

    // Dispose controllers
    messageController.dispose();
    scrollController.dispose();

    // Always call super.dispose() last
    super.dispose();
  }

  void _sendMessage() {
    final messageText = messageController.text.trim();

    try {
      ref.read(chatProvider(widget.user).notifier).sendMessage(messageText);

      // Clear the text field and update UI
      messageController.clear();

      // Schedule scroll to bottom with a slight delay to ensure messages are rendered
      Future.delayed(const Duration(milliseconds: 50), _scrollToBottom);
    } catch (e) {
      // Handle any errors that might occur
      debugPrint('Error sending message: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message. Please try again.')),
      );
    }
  }

  void _scrollToBottom() {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (scrollController.hasClients) {
          final position = scrollController.position;

          // Only scroll if we're not already at the bottom
          if (position.pixels != position.maxScrollExtent) {
            scrollController.animateTo(
              position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic, // Smoother animation curve
            );
          }
        }
      } catch (e) {
        // Silent catch for any animation errors
        debugPrint('Error scrolling to bottom: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(chatProvider(widget.user));

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 4.h, right: 2.h, left: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        widget.user.image,
                        fit: BoxFit.cover,
                        height: 5.h,
                        width: 5.h,
                      ),
                    ),
                    if (widget.user.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 1.h,
                          width: 1.h,
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
                SizedBox(width: 2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.nickname ?? widget.user.name,
                      style: TextStyle(
                        // fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.user.isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color:
                            widget.user.isOnline ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) => Container(
                    //     padding: EdgeInsets.symmetric(
                    //       vertical: 2.h,
                    //       horizontal: 4.w,
                    //     ),
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         ListTile(
                    //           leading: Icon(Icons.person),
                    //           title: Text('View Profile'),
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       UserProfile(user: widget.user),
                    //                 ));
                    //           },
                    //         ),
                    //         ListTile(
                    //           leading: Icon(Icons.block),
                    //           title: Text('Block User'),
                    //           onTap: () {
                    //             Navigator.pop(context);
                    //           },
                    //         ),
                    //         ListTile(
                    //           leading: Icon(Icons.delete, color: Colors.red),
                    //           title: Text(
                    //             'Clear Chat',
                    //             style: TextStyle(color: Colors.red),
                    //           ),
                    //           onTap: () {
                    //             Navigator.pop(context);
                    //             // Clear chat using the provider
                    //             ref
                    //                 .read(chatProvider(widget.user).notifier)
                    //                 .clearChat();
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserProfile(user: widget.user)));
                  },
                  icon: Icon(Icons.more_vert, size: 6.w),
                ),
              ],
            ),
            chatMessages.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Center(
                      child: Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            Expanded(
              child: chatMessages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 15.w,
                            color: Colors.orange,
                          ),
                          Text(
                            'No messages yet',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Send a message to start chatting',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = chatMessages[index];
                        final showTimeForMessage =
                            index == chatMessages.length - 1 ||
                                (index < chatMessages.length - 1 &&
                                    chatMessages[index].isMe !=
                                        chatMessages[index + 1].isMe);

                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: MessageBubble(
                            message: message.message,
                            isMe: message.isMe,
                            time: message.time,
                            showTime: showTimeForMessage,
                            userImage: message.isMe ? null : widget.user.image,
                          ),
                        );
                      },
                    ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 25.h,
                          padding: EdgeInsets.all(4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Share Content',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _attachmentOption(
                                    icon: Icons.image,
                                    label: 'Gallery',
                                    color: Colors.purple,
                                  ),
                                  _attachmentOption(
                                    icon: Icons.camera_alt,
                                    label: 'Camera',
                                    color: Colors.red,
                                  ),
                                  _attachmentOption(
                                    icon: Icons.insert_drive_file,
                                    label: 'Document',
                                    color: Colors.blue,
                                  ),
                                  _attachmentOption(
                                    icon: Icons.location_on,
                                    label: 'Location',
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.attach_file, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _attachmentOption({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 6.w),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: TextStyle(fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime time;
  final bool showTime;
  final String? userImage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
    this.showTime = true,
    this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe && userImage != null)
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: ClipOval(
              child: Image.asset(
                userImage!,
                height: 4.h,
                width: 4.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (!isMe && userImage == null) SizedBox(width: 4.h + 2.w),
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isMe ? Colors.orange : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: isMe ? Radius.circular(0) : Radius.circular(12),
                  topRight: isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (showTime)
              Padding(
                padding: EdgeInsets.only(top: 0.5.h),
                child: Text(
                  // show the time in the hourly format
                  DateFormat('h:mm a').format(time),
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
