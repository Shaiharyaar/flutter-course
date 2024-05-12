import 'package:flutter_project_1/screens/home_screen.dart';
import 'package:flutter_project_1/screens/quiz_screen.dart';
import 'package:flutter_project_1/screens/statistics_screen.dart';
import 'package:flutter_project_1/screens/topic_screen.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: SharedLocationConstants.home,
        builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: SharedLocationConstants.topics,
        builder: (context, state) => const TopicScreen()),
    GoRoute(
        path: SharedLocationConstants.statistics,
        builder: (context, state) => const StatisticsScreen()),
    GoRoute(
      path: SharedLocationConstants.quiz,
      builder: (context, state) => const QuizScreen(),
    ),
  ],
);
