import 'package:flutter/material.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_project_1/util/screen_wrapper.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  _goToTopicScreen(BuildContext context) {
    context.go(SharedLocationConstants.topics);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Quiz app",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800),
            ),
            const SizedBox(height: 10),
            const Text(
              "Would you like to start your quiz?",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: () => _goToTopicScreen(context),
                child: const Text('Start quiz'))
          ],
        ),
      ),
    );
  }
}
