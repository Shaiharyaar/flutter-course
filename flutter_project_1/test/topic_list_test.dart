import 'dart:convert';

import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/quiz_app.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

final topicList = [
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

void main() async {
  testWidgets("Topic List is rendered correctly", (tester) async {
    SharedPreferences.setMockInitialValues({
      SharedKeyConstants.topicList:
          topicList.map((topic) => jsonEncode(topic.toJson())).toList(),
    });
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const QuizApp(),
    ));
    await tester.pumpAndSettle();
    final goToTopicsButton = find.text("Go select a topic");
    expect(goToTopicsButton, findsOneWidget);
    await tester.tap(goToTopicsButton);
    await tester.pumpAndSettle();
    final findTopicTitle = find.text("Select a Quiz topic");
    expect(findTopicTitle, findsOneWidget);
    for (var topic in topicList) {
      final findFirstTopic = find.text(topic.name);
      expect(findFirstTopic, findsOneWidget);
    }
  });
}
