import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_throttle_debounce/flutter_throttle_debounce.dart';
import 'package:todo_flutter/domain/models/todo.dart';
import 'package:todo_flutter/providers/todo_provider.dart';

final throttler = Throttler(interval: Duration(seconds: 1));

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                todo.name,
                style: TextStyle(
                  decoration: !todo.status ? TextDecoration.lineThrough : null,
                  color: !todo.status ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          !todo.status ? SizedBox(width: 0) : const SizedBox(width: 8),
          !todo.status
              ? SizedBox(width: 0)
              : Row(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        return IconButton(
                          onPressed: () {
                            throttler(() {
                              ref
                                  .read(todoProvider.notifier)
                                  .toggleStatusDoneTodo(todo.id);
                            });
                          },
                          icon: Icon(
                            todo.status && todo.currentTab == "Done"
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: todo.status && todo.currentTab == "Done"
                                ? Colors.green
                                : Colors.black,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Consumer(
                      builder: (context, ref, child) {
                        return IconButton(
                          onPressed: () {
                            ref.read(todoProvider.notifier).removeTodo(todo.id);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        );
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
