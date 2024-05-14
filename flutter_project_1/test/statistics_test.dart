import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/statistics.dart';
import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/quiz_app.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<Topic> topicsList = [
  Topic(id: 1, name: "Basic arithmetics", questionPath: "/topics/1/questions"),
  Topic(
      id: 2,
      name: "Countries and capitals",
      questionPath: "/topics/2/questions"),
  Topic(
      id: 3,
      name: "Countries and continents",
      questionPath: "/topics/3/questions"),
  Topic(id: 4, name: "Dog breeds", questionPath: "/topics/4/questions")
];

final List<Statistics> statisticsData = [
  Statistics(
      topicId: 1,
      topicName: "Basic arithmetics",
      totalQuestionCount: 20,
      totalCorrectAnswerCount: 12),
  Statistics(
      topicId: 2,
      topicName: "Countries and capitals",
      totalQuestionCount: 10,
      totalCorrectAnswerCount: 5),
  Statistics(
      topicId: 3,
      topicName: "Countries and continents",
      totalQuestionCount: 1,
      totalCorrectAnswerCount: 0),
  Statistics(
      topicId: 4,
      topicName: "Dog breeds",
      totalQuestionCount: 8,
      totalCorrectAnswerCount: 4)
];

void main() async {
  testWidgets("Total correct answer count in Statistics are shown",
      (tester) async {
    SharedPreferences.setMockInitialValues({
      SharedKeyConstants.topicList:
          topicsList.map((topic) => jsonEncode(topic.toJson())).toList(),
      SharedKeyConstants.statistics:
          statisticsData.map((stats) => jsonEncode(stats.toJson())).toList()
    });
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const QuizApp(),
    ));
    await tester.pumpAndSettle();
    final goToStatsButton = find.byIcon(Icons.bar_chart);
    expect(goToStatsButton, findsOneWidget);
    await tester.tap(goToStatsButton);
    await tester.pumpAndSettle();
    final totalCorrectAnswers =
        statisticsData.fold<int>(0, (previousValue, stats) {
      return previousValue + stats.totalCorrectAnswerCount;
    });
    final totalCorrectAnswerText =
        find.text("Total Correct answers: $totalCorrectAnswers");
    expect(totalCorrectAnswerText, findsOneWidget);
  });

  testWidgets("topic-based statistics are shown", (tester) async {
    SharedPreferences.setMockInitialValues({
      SharedKeyConstants.topicList:
          topicsList.map((topic) => jsonEncode(topic.toJson())).toList(),
      SharedKeyConstants.statistics:
          statisticsData.map((stats) => jsonEncode(stats.toJson())).toList()
    });
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const QuizApp(),
    ));
    await tester.pumpAndSettle();
    final goToStatsButton = find.byIcon(Icons.bar_chart);
    expect(goToStatsButton, findsOneWidget);
    await tester.tap(goToStatsButton);
    await tester.pumpAndSettle();
    for (var stats in statisticsData) {
      expect(find.text(stats.topicName), findsOneWidget);
      expect(find.text("Total questions: ${stats.totalQuestionCount}"),
          findsOneWidget);
      expect(
          find.text("Total correct answers: ${stats.totalCorrectAnswerCount}"),
          findsOneWidget);
      expect(
          find.text(
              "Total wrong answers: ${stats.totalQuestionCount - stats.totalCorrectAnswerCount}"),
          findsOneWidget);
    }
  });
}
