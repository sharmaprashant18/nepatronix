import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/model/chat_message_model.dart';
import 'package:nepatronix/model/chat_model.dart';

class ChatMessageNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessageNotifier() : super([]);
  void sendMessage(String message) {
    if (message.trim().isEmpty) return;
    final newMessage =
        ChatMessage(message: message, isMe: true, time: DateTime.now());
    state = [...state, newMessage];
  }

  void clearChat() {
    state = [];
  }
}

final chatProvider = StateNotifierProvider.family<ChatMessageNotifier,
    List<ChatMessage>, UserModel>((ref, user) {
  return ChatMessageNotifier();
});
