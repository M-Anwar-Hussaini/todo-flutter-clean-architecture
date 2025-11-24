import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}
