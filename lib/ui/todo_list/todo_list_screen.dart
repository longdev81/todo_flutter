import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_flutter/providers/todo_provider.dart';
import 'package:todo_flutter/routing/app_route.dart';
import 'package:todo_flutter/ui/core/todo_list/widgets/modal_add_task.dart';
import 'package:todo_flutter/ui/core/todo_list/widgets/todo_search_bar.dart';
import 'package:todo_flutter/ui/core/todo_list/widgets/todo_list.dart';

class TodoListScreen extends HookConsumerWidget {
  const TodoListScreen({super.key});

  void handleAddTask(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddTaskModal(),
    );

    if (result != null && result.isNotEmpty) {
      ref.read(todoProvider.notifier).addTodo(result);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(title: const Text("Todo List")),
          body: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                TodoSearchBar(
                  onChanged: (value) =>
                      ref.read(todoProvider.notifier).updateSearchQuery(value),
                  onAddTap: () => handleAddTask(context, ref),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.secondRoute);
                  },
                  child: Text("TextRoute"),
                ),
                const TodoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
