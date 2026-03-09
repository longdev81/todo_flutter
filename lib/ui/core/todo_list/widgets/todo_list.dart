import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_flutter/domain/models/todo.dart';
import 'package:todo_flutter/providers/todo_provider.dart';
import 'package:todo_flutter/ui/core/todo_list/widgets/todo_item.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TodoState(todos: listTodos, :searchQuery) = ref.watch(todoProvider);

    final filteredList = listTodos
        .where((t) => t.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    final allTodos = filteredList.where((t) => t.currentTab == "All").toList();

    final List<Todo> doneTodos = filteredList
        .where((t) => t.currentTab == "Done")
        .toList();

    final List<Todo> deletedTodos = filteredList
        .where((t) => t.currentTab == "Deleted")
        .toList();

    return Expanded(
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Done"),
              Tab(text: "Deleted"),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children: [
                _buildTaskView(allTodos),
                _buildTaskView(doneTodos),
                _buildTaskView(deletedTodos),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskView(List<Todo> todos) {
    if (todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_outlined, color: Colors.grey[300], size: 64),
            const SizedBox(height: 12),
            const Text(
              "không có task",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoItem(todo: todos[index]);
      },
    );
  }
}
