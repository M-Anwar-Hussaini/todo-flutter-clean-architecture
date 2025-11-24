import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/todo_entities.dart';
import '../../bloc/todo_bloc.dart';
import '../../bloc/todo_event.dart';
import '../../bloc/todo_state.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(child: Text('No todos yet. Add some!'));
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text(todo.description),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      context.read<TodoBloc>().add(
                        UpdateTodo(
                          TodoEntity(
                            id: todo.id,
                            title: todo.title,
                            description: todo.description,
                            isCompleted: value ?? false,
                          ),
                        ),
                      );
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TodoBloc>().add(DeleteTodo(todo.id));
                    },
                  ),
                  onTap: () {
                    _showAddEditDialog(context, todo: todo);
                  },
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, {TodoEntity? todo}) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descriptionController = TextEditingController(
      text: todo?.description ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                if (title.isNotEmpty) {
                  if (todo == null) {
                    context.read<TodoBloc>().add(
                      AddTodo(
                        TodoEntity(
                          id: const Uuid().v4(),
                          title: title,
                          description: description,
                          isCompleted: false,
                        ),
                      ),
                    );
                  } else {
                    context.read<TodoBloc>().add(
                      UpdateTodo(
                        TodoEntity(
                          id: todo.id,
                          title: title,
                          description: description,
                          isCompleted: todo.isCompleted,
                        ),
                      ),
                    );
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
