import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './todo_list.dart';
import './todo_form.dart';

void main() {
  runApp(ProviderScope(child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: Column(children: [TodoForm(), TodoList()])));
  }
}
