import 'package:flutter_project_2/screens/login_screen.dart';
import 'package:flutter_project_2/screens/nav_screen.dart';
import 'package:flutter_project_2/utils/constants.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: RoutesPath.home, builder: (context, state) => const NavScreen()),
    GoRoute(
        path: RoutesPath.login,
        builder: (context, state) => const LoginScreen()),
  ],
);
