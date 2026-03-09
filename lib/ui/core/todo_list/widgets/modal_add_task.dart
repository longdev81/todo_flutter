import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/providers/todo_provider.dart';
import 'package:todo_flutter/ui/core/ui/widgets/search_input.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  String _taskName = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchInput(
            onChanged: (value) {
              setState(() {
                _taskName = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: _taskName.trim().isEmpty
                    ? null
                    : () {
                        ref.read(todoProvider.notifier).addTodo(_taskName);
                        Navigator.pop(context);
                        setState(() {
                          _taskName = "";
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Thêm Task'),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
