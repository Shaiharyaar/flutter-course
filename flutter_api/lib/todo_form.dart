import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers.dart';


class TodoForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends ConsumerState<TodoForm> {
  final _todoNameController = TextEditingController();

  _addTodo() {
    ref.watch(todoProvider.notifier).addTodo(_todoNameController.text);
    _todoNameController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _todoNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _todoNameController,
        decoration: const InputDecoration(
            hintText: 'Todo name', border: OutlineInputBorder()),
      ),
      ElevatedButton(onPressed: _addTodo, child: const Text('Add todo')),
    ]);
  }
}
