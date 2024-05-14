import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/providers/generic_provider.dart';
import 'package:flutter_project_1/providers/is_quiz_provider.dart';
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
    ref.read(topicProvider.notifier).update(topic);
    ref.read(genericProvider.notifier).state = false;
    ref.read(isQuizPageProvider.notifier).state = true;
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
        ? SingleChildScrollView(
            child: Column(
              children: [
                ...items,
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onPressed: () => context.go('/'),
                  child: const SizedBox(
                      width: 60,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text('Back')
                          ],
                        ),
                      )),
                )
              ],
            ),
          )
        : const Center(
            child: Text('The list of topics is empty'),
          );
  }
}
