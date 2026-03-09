import 'package:flutter/cupertino.dart';
import 'package:todo_flutter/ui/todo_list/second_route.dart';
import 'package:todo_flutter/ui/todo_list/todo_list_screen.dart';

class AppRoute {
  static const String todoList = '/todo_list';
  static const String secondRoute = '/second_route';

  static Map<String, WidgetBuilder> get routes => {
    todoList: (context) => const TodoListScreen(),
    secondRoute: (context) => const SecondRoute(),
  };
}
