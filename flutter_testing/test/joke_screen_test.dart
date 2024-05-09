import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/screens/joke_screen.dart';

void main() {
  testWidgets("JokeScreen contains text 'Back'", (tester) async {
    await tester.pumpWidget(MaterialApp(home: JokeScreen()));
    final backTextFinder = find.text('Back');
    expect(backTextFinder, findsOneWidget);
  });
  testWidgets("JokeScreen contains Two container with text widget",
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: JokeScreen()));
    final containersWithText = find.byWidgetPredicate(
        (widget) => widget is Container && widget.child is Text);

    expect(containersWithText, findsNWidgets(2));
  });
}
