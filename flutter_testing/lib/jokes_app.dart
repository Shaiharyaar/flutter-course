import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/joke_screen.dart';

class JokesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => HomeScreen(),
      '/joke': (context) => JokeScreen(),
    });
  }
}
