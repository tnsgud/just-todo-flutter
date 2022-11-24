import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_todo/components/icon_text_field.dart';
import 'package:just_todo/models/todo.dart';

class DefaultTodoScreen extends StatefulWidget {
  final Color primaryColor;
  final String title;
  final List<Todo> list;

  const DefaultTodoScreen({
    super.key,
    required this.primaryColor,
    required this.title,
    required this.list,
  });

  get count => list.length;

  @override
  State<DefaultTodoScreen> createState() => _DefaultTodoScreenState();
}

class _DefaultTodoScreenState extends State<DefaultTodoScreen> {
  late List<Todo> _todoList;

  @override
  void initState() {
    super.initState();
    _todoList = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
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
                onTap: () {},
                leading: const Icon(Icons.circle_outlined),
                title: Text(_todoList[index].content),
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
            icon: Icons.add,
            iconColor: widget.primaryColor,
            fillColor: Theme.of(context).backgroundColor.withAlpha(100),
            hintText: '작업 추가',
          ),
        ],
      ),
    );
  }
}
