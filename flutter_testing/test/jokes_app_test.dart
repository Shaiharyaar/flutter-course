import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/jokes_app.dart';
import 'package:flutter_testing/screens/home_screen.dart';

void main() {
  testWidgets("JokesApp shows HomeScreen at start.", (tester) async {
    await tester.pumpWidget(JokesApp());
    final homeScreenFinder = find.byType(HomeScreen);
    expect(homeScreenFinder, findsOneWidget);
  });

  testWidgets("JokeScreen button with text 'Back' click leads to HomeScreen",
      (tester) async {
    await tester.pumpWidget(JokesApp());
    await tester.tap(find.text('Hmm...'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    final homeScreenFinder = find.byType(HomeScreen);
    expect(homeScreenFinder, findsOneWidget);
  });
}
