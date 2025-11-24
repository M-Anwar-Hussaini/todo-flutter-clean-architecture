import 'package:equatable/equatable.dart';
import '../../domain/entities/todo_entities.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class LoadTodos extends TodoEvent {}

final class AddTodo extends TodoEvent {
  final TodoEntity todo;

  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

final class UpdateTodo extends TodoEvent {
  final TodoEntity todo;

  const UpdateTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

final class DeleteTodo extends TodoEvent {
  final String id;

  const DeleteTodo(this.id);

  @override
  List<Object> get props => [id];
}
