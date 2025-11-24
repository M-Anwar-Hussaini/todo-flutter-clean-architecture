import 'package:equatable/equatable.dart';
import '../../domain/entities/todo_entities.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<TodoEntity> todos;

  const TodoLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

final class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object> get props => [message];
}
