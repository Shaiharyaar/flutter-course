import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers.dart';

class TodoList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final items = List<Widget>.from(todos.map(
      (todo) => ListTile(
        leading: IconButton(
          icon: Icon(todo.completed
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank),
          onPressed: () =>
              ref.watch(todoProvider.notifier).updateCompleted(todo),
        ),
        title: Text(todo.name),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => ref.watch(todoProvider.notifier).delete(todo),
        ),
      ),
    ));
    return Expanded(child: ListView(children: items));
  }
}
