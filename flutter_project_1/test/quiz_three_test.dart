import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/quiz.dart';
import 'package:flutter_project_1/models/statistics.dart';
import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/routes/routes.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
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

const quizResponse = {
  "id": 1,
  "question": "What is the outcome of 10 + 10?",
  "options": ["6", "20", "10", "200", "49"],
  "answer_post_path": "/topics/1/questions/1/answers"
};

const lowestAnswerCountQuizRes = {
  "id": 8,
  "question": "In what continent is Armenia located?",
  "options": ["America", "Africa", "Asia"],
  "answer_post_path": "/topics/3/questions/8/answers"
};
const correctSelectionFeedbackResponse = {"correct": true};
const incorrectSelectionFeedbackResponse = {"correct": false};

void main() async {
  const baseUrl = 'https://dad-quiz-api.deno.dev';

  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets(
      "Verifying Option select feedback of quiz for incorrect option selection",
      (tester) async {
    final quizInterceptor = nock(baseUrl).get("/topics/1/questions")
      ..reply(200, quizResponse);
    final feedbackInterceptor = nock(baseUrl)
        .post("/topics/1/questions/1/answers", json.encode({'answer': '200'}))
      ..reply(200, incorrectSelectionFeedbackResponse);

    Quiz quiz = Quiz.fromJson(quizResponse);

    SharedPreferences.setMockInitialValues({
      SharedKeyConstants.topicList:
          topicsList.map((topic) => jsonEncode(topic.toJson())).toList(),
      SharedKeyConstants.statistics:
          statisticsData.map((stats) => jsonEncode(stats.toJson())).toList()
    });
    final prefs = await SharedPreferences.getInstance();

    // Define the test key.
    const testKey = Key('third-quiz-test');

    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MaterialApp.router(key: testKey, routerConfig: router),
    ));
    await tester.pumpAndSettle();
    final goToTopicsButton = find.text("Go select a topic");
    expect(goToTopicsButton, findsOneWidget);
    await tester.tap(goToTopicsButton);
    await tester.pumpAndSettle();
    final goToFirstTopicButton = find.text(topicsList[0].name);
    expect(goToFirstTopicButton, findsOneWidget);

    await tester.tap(goToFirstTopicButton);
    await tester.pumpAndSettle();
    expect(quizInterceptor.isDone, true);
    expect(find.text(quiz.question), findsOneWidget);

    final selectOptionBtn = find.text('200');
    await tester.tap(selectOptionBtn);
    await tester.pump();
    expect(feedbackInterceptor.isDone, true);
    expect(find.text("Your answer is incorrect"), findsOneWidget);
  });
}
