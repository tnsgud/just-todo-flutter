import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_todo/components/icon_text_field.dart';
import 'package:just_todo/models/todo.dart';

class DefaultTodoScreen extends StatefulWidget {
  final Color primaryColor;
  final String title;

  const DefaultTodoScreen({
    super.key,
    required this.primaryColor,
    required this.title,
  });

  @override
  State<DefaultTodoScreen> createState() => _DefaultTodoScreenState();
}

class _DefaultTodoScreenState extends State<DefaultTodoScreen> {
  final List<Todo> _todoList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.title}/${_todoList.length}',
            textAlign: TextAlign.left,
            style: GoogleFonts.gothicA1(
              color: widget.primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => ListTile(
                style: ListTileStyle.list,
                onTap: () {
                  setState(() {
                    _todoList[index].isDone = !_todoList[index].isDone;
                  });
                },
                leading: Icon(_todoList[index].isDone
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined),
                title: Text(
                  _todoList[index].content,
                  style: TextStyle(
                      decoration: _todoList[index].isDone
                          ? TextDecoration.lineThrough
                          : null),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.star_border),
                  onPressed: () {},
                ),
              ),
              itemCount: _todoList.length,
            ),
          ),
          IconTextField(
            height: 50,
            controller: _controller,
            icon: Icons.add,
            iconColor: widget.primaryColor,
            fillColor: Theme.of(context).backgroundColor.withAlpha(100),
            hintText: '작업 추가',
            onEditingComplete: () {
              var content = _controller.text;

              _controller.clear();

              log('hello');

              setState(() {
                _todoList.add(Todo(content: content));
              });
            },
          ),
        ],
      ),
    );
  }
}
