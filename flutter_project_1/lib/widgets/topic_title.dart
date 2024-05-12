import 'package:flutter/material.dart';
import 'package:flutter_project_1/providers/topic_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopicTitle extends ConsumerWidget {
  const TopicTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topic = ref.watch(topicProvider);
    return topic != null
        ? Text(
            topic.name,
            style: TextStyle(fontSize: 24, color: Colors.purple.shade800),
          )
        : const Text("");
  }
}
