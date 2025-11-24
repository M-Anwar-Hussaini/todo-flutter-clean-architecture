import '../entities/todo_entities.dart';
import '../repository/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<List<TodoEntity>> call() async {
    return await repository.getTodos();
  }
}

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  Future<void> call(TodoEntity todo) async {
    return await repository.addTodo(todo);
  }
}

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<void> call(TodoEntity todo) async {
    return await repository.updateTodo(todo);
  }
}

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteTodo(id);
  }
}
