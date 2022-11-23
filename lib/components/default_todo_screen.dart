import 'package:flutter/material.dart';

class DefaultTodoScreen extends StatelessWidget {
  late Color primaryColor;
  late String title;

  DefaultTodoScreen({
    super.key,
    required this.primaryColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Text(title),
    );
  }
}
