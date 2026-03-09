import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/core/ui/widgets/search_input.dart';

class TodoSearchBar extends StatelessWidget {
  final VoidCallback? onAddTap;
  final ValueChanged<String> onChanged;

  const TodoSearchBar({super.key, required this.onChanged, this.onAddTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchInput(
            onChanged: (value) {
              onChanged.call(value);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          margin: EdgeInsets.only(left: 8),
          padding: EdgeInsets.symmetric(vertical: 2),
          child: IconButton(
            onPressed: () {
              onAddTap?.call();
            },
            icon: Icon(Icons.add),
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
