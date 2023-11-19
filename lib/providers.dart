import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

class UserModelStateNotifier extends StateNotifier<UserModel> {
  UserModelStateNotifier(UserModel user) : super(user);

  // Method to update the entire user
  void updateUser(UserModel newUser) {
    state = newUser;
  }
}

final userModelStateNotifierProvider = StateNotifierProvider<UserModelStateNotifier, UserModel>((ref) {
  UserModel initialUser = UserModel(
    id: '',
    email: '',
    phoneNumber: 0,
    balance: '',
    createAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: '',
  );
  return UserModelStateNotifier(initialUser);
});
