import 'package:flutter/material.dart';
import 'package:just_todo/components/default_todo_screen.dart';

class DrawerItemData {
  late IconData iconData;
  late Color color;
  late String title;
  DefaultTodoScreen? screen;

  DrawerItemData({
    required this.iconData,
    required this.color,
    required this.title,
    this.screen,
  });
}
