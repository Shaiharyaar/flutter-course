import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './screens/home_screen.dart';
import './screens/welcome_screen.dart';

main() {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );

  runApp(MaterialApp.router(routerConfig: router));
}
