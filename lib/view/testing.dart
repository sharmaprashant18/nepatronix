import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/model/chat_message_model.dart';
import 'package:nepatronix/model/chat_model.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

final chatMessagesProvider = StateNotifierProvider.family<ChatMessagesNotifier,
    List<ChatMessage>, UserModel>(
  (ref, user) => ChatMessagesNotifier(),
);

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessagesNotifier() : super([]);

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;

    final newMessage = ChatMessage(
      message: message,
      isMe: true,
      time: DateTime.now(),
    );

    state = [...state, newMessage];
  }

  void clearChat() {
    state = [];
  }
}

class PersonalChatting extends ConsumerStatefulWidget {
  const PersonalChatting({super.key, required this.user});
  final UserModel user;

  @override
  ConsumerState<PersonalChatting> createState() => _PersonalChatState();
}

class _PersonalChatState extends ConsumerState<PersonalChatting> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Cancel any pending animations before disposing controllers
    if (_scrollController.hasClients) {
      _scrollController.position.hold(() {});
    }

    // Dispose controllers
    _messageController.dispose();
    _scrollController.dispose();

    // Always call super.dispose() last
    super.dispose();
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();

    // Enhanced validation for empty messages
    if (messageText.isEmpty) {
      // Optional: show a snackbar or other feedback
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Message cannot be empty')),
      // );
      return;
    }

    try {
      // Send message through the provider
      ref
          .read(chatMessagesProvider(widget.user).notifier)
          .sendMessage(messageText);

      // Clear the text field and update UI
      _messageController.clear();

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
    // Make sure we're mounted before proceeding
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (_scrollController.hasClients) {
          final position = _scrollController.position;

          // Only scroll if we're not already at the bottom
          if (position.pixels != position.maxScrollExtent) {
            _scrollController.animateTo(
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
    // Watch for changes in the chat messages
    final chatMessages = ref.watch(chatMessagesProvider(widget.user));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 2.h, right: 2.h, left: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 6.w),
                    onPressed: () => Navigator.pop(context),
                  ),
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
                        widget.user.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.user.isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color:
                              widget.user.isOnline ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 15.h,
                          padding: EdgeInsets.symmetric(
                            vertical: 2.h,
                            horizontal: 4.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Call Options',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.call, size: 6.w),
                                        Text('Voice Call'),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.videocam, size: 6.w),
                                        Text('Video Call'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.call, size: 6.w),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.h,
                            horizontal: 4.w,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text('View Profile'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.block),
                                title: Text('Block User'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.delete, color: Colors.red),
                                title: Text(
                                  'Clear Chat',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Clear chat using the provider
                                  ref
                                      .read(chatMessagesProvider(widget.user)
                                          .notifier)
                                      .clearChat();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_vert, size: 6.w),
                  ),
                ],
              ),
              chatMessages.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[700],
                            ),
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
                              color: Colors.grey,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'No messages yet',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Send a message to start chatting',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
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
                              userImage:
                                  message.isMe ? null : widget.user.image,
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
                      color: Colors.grey.withOpacity(0.3),
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
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.emoji_emotions, color: Colors.amber),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 1.w),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: _sendMessage,
                        icon: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
              color: color.withOpacity(0.2),
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
    Key? key,
    required this.message,
    required this.isMe,
    required this.time,
    this.showTime = true,
    this.userImage,
  }) : super(key: key);

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
              constraints: BoxConstraints(maxWidth: 70.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isMe ? Colors.orange : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (showTime)
              Padding(
                padding: EdgeInsets.only(top: 0.5.h),
                child: Text(
                  DateFormat('h:mm a').format(time),
                  style: TextStyle(
                    fontSize: 8.sp,
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
