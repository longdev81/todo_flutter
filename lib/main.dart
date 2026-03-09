import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/routing/app_route.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: AppRoute.todoList,
        routes: AppRoute.routes,
      ),
    ),
  );
}
