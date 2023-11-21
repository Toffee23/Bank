import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models.dart';

final showBalanceProvider = StateProvider<bool>((ref) {
  return true;
});

class UserModelStateNotifier extends StateNotifier<UserModel> {
  UserModelStateNotifier(UserModel user) : super(user);

  void updateUser(UserModel newUser) {
    state = newUser;
  }

  void update({
    String? email,
    int? phoneNumber,
    num? balance,
    DateTime? createAt,
    DateTime? updatedAt,
    String? v,
  }) {
    state = state.copyWith(
      email: email ?? state.email,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      balance: balance ?? state.balance,
      createAt: createAt ?? state.createAt,
      updatedAt: updatedAt ?? state.updatedAt,
      v: v ?? state.v,
    );
  }
}

final userModelStateNotifierProvider = StateNotifierProvider<UserModelStateNotifier, UserModel>((ref) {
  UserModel initialUser = UserModel(
    id: '',
    email: '',
    phoneNumber: 0,
    balance: 0,
    createAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: '',
  );
  return UserModelStateNotifier(initialUser);
});