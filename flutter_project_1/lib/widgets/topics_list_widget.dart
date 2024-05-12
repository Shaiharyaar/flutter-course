import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/providers/quiz_provider.dart';
import 'package:flutter_project_1/providers/topic_provider.dart';
import 'package:flutter_project_1/providers/topics_provider.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopicsListWidget extends ConsumerWidget {
  const TopicsListWidget({super.key});

  _goToQuizScreen(BuildContext ctx, WidgetRef ref, Topic topic) {
    final quizNotifier = ref.watch(quizNotifierProvider);
    quizNotifier.updateQuiz(topic.questionPath);
    ref.read(topicProvider.notifier).updateTopic(topic);
    ctx.go(SharedLocationConstants.quiz);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicListProvider);
    final items = List<Widget>.from(topics.map(
      (topic) => ElevatedButton(
        onPressed: () => _goToQuizScreen(context, ref, topic),
        child: Text(topic.name),
      ),
    ));
    return items.isNotEmpty
        ? Column(
            children: items,
          )
        : const Center(
            child: Text('The list of topics is empty'),
          );
  }
}
