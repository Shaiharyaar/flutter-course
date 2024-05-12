import 'package:flutter/material.dart';
import 'package:flutter_project_1/providers/quiz_provider.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScreenWrapper extends ConsumerWidget {
  final Widget widget;
  const ScreenWrapper(this.widget, {super.key});

  _goToTopics(BuildContext context, WidgetRef ref) {
    final quizNotifier = ref.watch(quizNotifierProvider);
    quizNotifier.setQuiz(null);

    context.go(SharedLocationConstants.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _goToTopics(context, ref),
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Quiz App"),
        actions: [
          IconButton(
              onPressed: () => context.go(SharedLocationConstants.statistics),
              color: Colors.purple.shade800,
              icon: const Icon(Icons.bar_chart))
        ],
      ),
      body: widget,
    );
  }
}
