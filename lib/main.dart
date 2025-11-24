import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'feature/todo/presentation/bloc/todo_bloc.dart';
import 'feature/todo/presentation/bloc/todo_event.dart';
import 'feature/todo/presentation/views/screen/todo_screen.dart';
import 'feature/todo/todo_dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MainApp());
}

final _router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => const TodoScreen())],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TodoBloc>()..add(LoadTodos()),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Todo App',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      ),
    );
  }
}
