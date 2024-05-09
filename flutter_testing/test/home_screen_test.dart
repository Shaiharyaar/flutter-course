import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/jokes_app.dart';
import 'package:flutter_testing/screens/joke_screen.dart';

import '../lib/screens/home_screen.dart';

void main() {
  testWidgets("HomeScreen contains text 'Hmm...'", (tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    final hmmmTextFinder = find.text('Hmm...');
    expect(hmmmTextFinder, findsOneWidget);
  });
  testWidgets("HomeScreen button with text 'Hmm...' click leads to JokesScreen",
      (tester) async {
    await tester.pumpWidget(JokesApp());
    await tester.tap(find.text('Hmm...'));
    await tester.pumpAndSettle();
    final jokeScreenFinder = find.byType(JokeScreen);
    expect(jokeScreenFinder, findsOneWidget);
  });
}
