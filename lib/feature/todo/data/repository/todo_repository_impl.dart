import '../../domain/entities/todo_entities.dart';
import '../../domain/repository/todo_repository.dart';
import '../data_source/todo_local_data_source.dart';
import '../model/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<List<TodoEntity>> getTodos() async {
    return await localDataSource.getTodos();
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todos = await localDataSource.getTodos();
    todos.add(TodoModel.fromEntity(todo));
    await localDataSource.cacheTodos(todos);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await localDataSource.getTodos();
    todos.removeWhere((element) => element.id == id);
    await localDataSource.cacheTodos(todos);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final todos = await localDataSource.getTodos();
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index != -1) {
      todos[index] = TodoModel.fromEntity(todo);
      await localDataSource.cacheTodos(todos);
    }
  }
}
