import 'package:flutter/material.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_project_1/util/screen_wrapper.dart';
import 'package:flutter_project_1/widgets/generic_button.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  _goToTopicScreen(BuildContext context) {
    context.push(SharedLocationConstants.topics);
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
              "Would you like to select a topic for your quiz?",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToTopicScreen(context),
              child: const Text('Go select a topic'),
            ),
            const SizedBox(height: 20),
            const Text(
              "OR",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        blurRadius: 4,
                        color: Colors.grey,
                        offset: Offset(1, -1)),
                  ]),
            ),
            const SizedBox(height: 20),
            const Text(
              "Do you want to start generic practice quiz?",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 10),
            const GenericButton(),
          ],
        ),
      ),
    );
  }
}
