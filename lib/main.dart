import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/ui/todo_list/todo_list_screen.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: TodoListScreen())));
}
