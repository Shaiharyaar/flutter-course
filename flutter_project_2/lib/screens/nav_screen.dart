import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2/providers/current_index_nav_provider.dart';
import 'package:flutter_project_2/providers/loading_provider.dart';
import 'package:flutter_project_2/providers/user_provider.dart';
import 'package:flutter_project_2/screens/category_screen.dart';
import 'package:flutter_project_2/screens/home_screen.dart';
import 'package:flutter_project_2/screens/profile_screen.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:flutter_project_2/widgets/bottom_navigation_bar.dart';
import 'package:flutter_project_2/widgets/custom_search_delegate.dart';
import 'package:flutter_project_2/widgets/loading_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavScreen extends ConsumerWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(asyncUserProvider);
    final currentIndex = ref.watch(currentIndexNavProvider);
    return Scaffold(
      body: LoadingContainer(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: const Text(
                "Yumly",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      asyncUser.when(
                          data: (user) async {
                            if (user == null) {
                              context.go(RoutesPath.login);
                            } else {
                              ref
                                  .read(loadingStateProvider.notifier)
                                  .startLoader("Signing out 👨‍🍳");
                              await FirebaseAuth.instance.signOut();
                              Future.delayed(const Duration(milliseconds: 3000),
                                  () {
                                ref
                                    .read(loadingStateProvider.notifier)
                                    .stopLoader();
                                ref.read(userProvider.notifier).fetchUser();
                              });
                            }
                          },
                          error: (error, stackTrace) {},
                          loading: () {});
                      // ignore: use_build_context_synchronously
                    },
                    child: Text(
                      asyncUser.when(data: (user) {
                        return user == null ? 'Sign in' : 'Sign out';
                      }, error: (error, stackTrace) {
                        return 'Error';
                      }, loading: () {
                        return "Loading";
                      }),
                      style: const TextStyle(color: Colors.white),
                    )),
                IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () => showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(),
                        ))
              ],
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
            body: const [
              HomeScreen(),
              CategoryScreen(),
              ProfileScreen()
            ][currentIndex]),
      ),
    );
  }
}
