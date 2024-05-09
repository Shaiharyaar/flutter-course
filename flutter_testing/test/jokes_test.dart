import 'package:flutter_test/flutter_test.dart';

import '../lib/jokes/jokes.dart';

void main() {
  test('randomJoke returns a joke and not the specific question', () async {
    final joke = JokeRepository.randomJoke();
    expect(joke, isNotNull);
    expect(joke.question,
        isNot(equals("What's orange and sounds like a parrot?")));
  });
}
