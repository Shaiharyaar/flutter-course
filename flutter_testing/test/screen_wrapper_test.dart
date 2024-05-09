import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/screens/util/screen_wrapper.dart';

void main() {
  testWidgets("HomeScreen contains text 'Hmm...'", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ScreenWrapper(Text(''))));
    final dadJokesTextFinder = find.text('DAD Jokes');
    expect(dadJokesTextFinder, findsOneWidget);
  });
}
