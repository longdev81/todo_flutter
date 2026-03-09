// lib/providers/todo_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/domain/models/todo.dart';

class TodoState {
  final List<Todo> todos;
  final String searchQuery;

  TodoState({required this.todos, required this.searchQuery});

  TodoState copyWith({List<Todo>? todos, String? searchQuery}) {
    return TodoState(
      todos: todos ?? this.todos,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class TodoNotifier extends Notifier<TodoState> {
  @override
  TodoState build() {
    return TodoState(todos: [], searchQuery: "");
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query.trim());
  }

  void addTodo(String nameTodo) {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      name: nameTodo,
      currentTab: "All",
      status: true,
    );
    state = state.copyWith(todos: [...state.todos, newTodo]);
  }

  void toggleStatusDoneTodo(String id) {
    state = state.copyWith(
      todos: state.todos.map((t) {
        if (t.id == id) {
          return t.copyWith(currentTab: t.currentTab == "All" ? "Done" : "All");
        }
        return t;
      }).toList(),
    );
  }

  void removeTodo(String id) {
    state = state.copyWith(
      todos: state.todos.map((t) {
        if (t.id == id) {
          return t.copyWith(currentTab: "Deleted", status: false);
        }
        return t;
      }).toList(),
    );
  }
}

final todoProvider = NotifierProvider<TodoNotifier, TodoState>(
  TodoNotifier.new,
);
