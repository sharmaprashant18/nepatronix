import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/model/chat_model.dart';

// Provider that maintains the list of all users
final usersProvider = StateNotifierProvider<UsersNotifier, List<UserModel>>(
  (ref) => UsersNotifier(),
);

// Provider to get a specific user by name
final userByNameProvider = Provider.family<UserModel?, String>(
  (ref, name) {
    final users = ref.watch(usersProvider);
    return users.firstWhere((user) => user.name == name,
        orElse: () => throw Exception('User not found'));
  },
);

// Notifier class to manage users state
class UsersNotifier extends StateNotifier<List<UserModel>> {
  UsersNotifier() : super(sampleUsers);

  // Update user nickname
  void updateNickname(UserModel user, String nickname) {
    state = state.map((u) {
      if (u.name == user.name) {
        return UserModel(
          name: u.name,
          image: u.image,
          isOnline: u.isOnline,
          message: u.message,
          lastMessageTime: u.lastMessageTime,
          nickname: nickname,
        );
      }
      return u;
    }).toList();
  }

  // Delete user
  void deleteUser(UserModel user) {
    state = state.where((u) => u.name != user.name).toList();
  }
}
