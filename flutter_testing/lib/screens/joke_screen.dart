import 'package:flutter/material.dart';
import '../jokes/jokes.dart';
import './util/screen_wrapper.dart';

class JokeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final joke = JokeRepository.randomJoke();
    const insets = EdgeInsets.all(40);
    return ScreenWrapper(
      Center(
        child: Column(
          children: [
            Container(margin: insets, child: Text(joke.question)),
            Container(margin: insets, child: Text(joke.punchline)),
            TextButton(
              child: const Text("Back"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
