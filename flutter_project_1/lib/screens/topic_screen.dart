import 'package:flutter/material.dart';
import 'package:flutter_project_1/util/screen_wrapper.dart';
import 'package:flutter_project_1/widgets/topics_list_widget.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Select a Quiz topic", style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                TopicsListWidget(),
              ])),
    );
  }
}
