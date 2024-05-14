import 'package:flutter/material.dart';
import 'package:flutter_project_1/providers/generic_provider.dart';
import 'package:flutter_project_1/providers/is_quiz_provider.dart';
import 'package:flutter_project_1/providers/quiz_provider.dart';
import 'package:flutter_project_1/providers/statistics_provider.dart';
import 'package:flutter_project_1/providers/topic_provider.dart';
import 'package:flutter_project_1/providers/topics_provider.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_project_1/util/handlers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GenericButton extends ConsumerWidget {
  const GenericButton({super.key});

  _goToQuizScreen(BuildContext ctx, WidgetRef ref) async {
    final topics = ref.watch(topicListProvider);
    final stats = ref.watch(statisticsProvider);
    final topic = await getLeastCorrectAnswerTopic(stats, topics);

    final quizNotifier = ref.watch(quizNotifierProvider);
    quizNotifier.updateQuiz(topic.questionPath);
    ref.read(topicProvider.notifier).update(topic);
    ref.read(genericProvider.notifier).state = true;
    ref.read(isQuizPageProvider.notifier).state = true;

    // ignore: use_build_context_synchronously
    ctx.go(SharedLocationConstants.quiz);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => _goToQuizScreen(context, ref),
      child: const Text('Generic Practice'),
    );
  }
}
