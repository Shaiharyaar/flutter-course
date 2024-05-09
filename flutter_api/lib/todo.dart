class Todo {
  final int id;
  final String name;
  final bool completed;

  Todo.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['id'],
        name = jsonData['name'],
        completed = jsonData['completed'];
}
