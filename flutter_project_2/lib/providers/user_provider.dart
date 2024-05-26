import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null) {
    fetchUser();
  }

  void fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    state = user;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());
