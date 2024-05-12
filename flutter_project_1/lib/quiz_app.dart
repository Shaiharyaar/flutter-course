import 'package:flutter/material.dart';
import 'package:flutter_project_1/routes/routes.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
