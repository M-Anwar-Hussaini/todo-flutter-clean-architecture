import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> cacheTodos(List<TodoModel> todos);
}

const cachedTodosKey = 'CACHED_TODOS';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;

  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TodoModel>> getTodos() async {
    final jsonString = sharedPreferences.getString(cachedTodosKey);
    if (jsonString != null) {
      final List<dynamic> jsonMap = json.decode(jsonString);
      return jsonMap.map((e) => TodoModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    final String jsonString = json.encode(
      todos.map((e) => e.toJson()).toList(),
    );
    await sharedPreferences.setString(cachedTodosKey, jsonString);
  }
}
