import 'package:flutter/material.dart';
import 'package:flutter_project_1/util/screen_wrapper.dart';
import 'package:flutter_project_1/widgets/mcq.dart';
import 'package:flutter_project_1/widgets/topic_title.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                TopicTitle(),
                SizedBox(height: 20),
                MCQForm(),
              ])),
    );
  }
}
