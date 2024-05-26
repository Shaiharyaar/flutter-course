import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_2/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(asyncUserProvider);
    return Center(
      child: Text(
        asyncUser.when(
          data: (user) {
            print(user);
            return user == null
                ? "You are not signed in"
                : "You are signed in anonymously";
          },
          error: (err, skipError) {
            return "Error loading user";
          },
          loading: () {
            return "Loading user data";
          },
        ),
      ),
    );
  }
}
