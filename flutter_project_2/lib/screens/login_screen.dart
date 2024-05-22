import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_2/providers/loading_provider.dart';
import 'package:flutter_project_2/providers/user_provider.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/widgets/loading_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);
    return Scaffold(
      body: LoadingContainer(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_wallpaper.jpg"),
              fit: BoxFit.cover,
            ),
            color: Colors.black87,
          ),
          child: Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.login, color: Colors.white),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              label: Text(
                asyncUser.when(
                  data: (user) =>
                      user == null ? 'Login anonymously' : 'You are logged In',
                  error: (error, stackTrace) {
                    return "Something went wrong..";
                  },
                  loading: () {
                    return "Loading...";
                  },
                ),
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                ref
                    .read(loadingStateProvider.notifier)
                    .startLoader("Logging in 👨‍🍳");
                asyncUser.when(data: (user) async {
                  if (user == null) {
                    final userInfo =
                        await FirebaseAuth.instance.signInAnonymously();
                    if (userInfo.user != null) {
                      // just for visual effect :)
                      Future.delayed(const Duration(milliseconds: 3000), () {
                        context.go(RoutesPath.home);
                        ref.read(loadingStateProvider.notifier).stopLoader();
                      });
                    }
                  }
                }, error: (err, stackTrace) {
                  print(err);
                }, loading: () {
                  print("Loading...");
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
