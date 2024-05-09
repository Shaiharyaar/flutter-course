import 'dart:convert';
import 'package:http/http.dart' as http;

import './todo.dart';

class TodoApi {
  Future<List<Todo>> findAll() async {
    final response = await http.get(
      Uri.parse('https://fitech-api.deno.dev/todos'),
    );
    List<dynamic> todoItems = jsonDecode(response.body);
    return List<Todo>.from(todoItems.map(
      (jsonData) => Todo.fromJson(jsonData),
    ));
  }

  Future<Todo> create(String name) async {
    final data = {"name": name};

    final response = await http.post(
      Uri.parse('https://fitech-api.deno.dev/todos'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(data),
    );

    return Todo.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.parse('https://fitech-api.deno.dev/todos/$id'));
  }

  Future<void> updateCompleted(int id) async {
    // do something here
    await http.post(Uri.parse('https://fitech-api.deno.dev/todos/${id}'));
  }
}
