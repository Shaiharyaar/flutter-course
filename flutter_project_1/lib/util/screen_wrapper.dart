import 'package:flutter/material.dart';
import 'package:flutter_project_1/providers/is_quiz_provider.dart';
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
    ref.read(isQuizPageProvider.notifier).state = false;
    context.go(SharedLocationConstants.topics);
  }

  _goToStats(BuildContext context, WidgetRef ref) {
    ref.read(isQuizPageProvider.notifier).state = false;
    context.go(SharedLocationConstants.statistics);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isQuizPage = ref.watch(isQuizPageProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quizzify"),
        actions: [
          isQuizPage
              ? IconButton(
                  onPressed: () => _goToTopics(context, ref),
                  color: Colors.purple.shade800,
                  icon: const Icon(Icons.list_alt_rounded))
              : const SizedBox(),
          IconButton(
              onPressed: () => _goToStats(context, ref),
              color: Colors.purple.shade800,
              icon: const Icon(Icons.bar_chart))
        ],
      ),
      body: widget,
    );
  }
}
