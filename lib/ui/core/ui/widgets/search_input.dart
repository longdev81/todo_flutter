import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchInput extends HookWidget {
  final ValueChanged<String> onChanged;
  const SearchInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    useListenable(controller);

    useEffect(() {
      Timer? timer;

      void listener() {
        if (timer?.isActive ?? false) timer?.cancel();

        timer = Timer(const Duration(milliseconds: 500), () {
          onChanged(controller.text);
        });
      }

      controller.addListener(listener);

      return () {
        controller.removeListener(listener);
        timer?.cancel();
      };
    }, [controller]);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm task',
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(Icons.close),
                color: Colors.blueGrey,
              ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
        ),
      ),
    );
  }
}
