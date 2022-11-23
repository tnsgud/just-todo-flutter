import 'package:flutter/material.dart';
import 'package:just_todo/models/todo.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  bool _isBottomAppBarVisible = false;
  final TextEditingController _textEditingController = TextEditingController();
  final List<Todo> _todoList = [];

  void _changeBottomAppBarVisible() {
    setState(() {
      _isBottomAppBarVisible = !_isBottomAppBarVisible;
    });
  }

  void _addTodo() {
    var todo = Todo(content: _textEditingController.text);

    _textEditingController.text = '';

    setState(() {
      _todoList.add(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          '계획된 일정',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  leading: _todoList[index].isDone
                      ? IconButton(
                          icon: const Icon(Icons.check_circle_rounded),
                          onPressed: () => setState(() {
                            _todoList[index].isDone = !_todoList[index].isDone;
                          }),
                        )
                      : IconButton(
                          icon: const Icon(Icons.circle_outlined),
                          onPressed: () => setState(() {
                            _todoList[index].isDone = !_todoList[index].isDone;
                          }),
                        ),
                  title: Text(
                    _todoList[index].content,
                    style: TextStyle(
                      decoration: _todoList[index].isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _todoList.length,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _isBottomAppBarVisible
            ? BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: TextField(
                                onChanged: (value) => setState(() {}),
                                autofocus: true,
                                textInputAction: TextInputAction.done,
                                controller: _textEditingController,
                                onEditingComplete: _addTodo,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: _textEditingController.text.isEmpty
                                  ? null
                                  : _addTodo,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            PopupMenuButton(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(children: const [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 30,
                                  ),
                                  Text('기한 설정')
                                ]),
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(Icons.calendar_today),
                                    title: Text('오늘'),
                                  ),
                                ),
                                PopupMenuItem(
                                    child: Row(
                                  children: const [
                                    Icon(Icons.calendar_today),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('내일')
                                  ],
                                )),
                                const PopupMenuItem(child: Text('2')),
                                const PopupMenuItem(child: Text('2')),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : null,
      ),
      floatingActionButton: _isBottomAppBarVisible
          ? null
          : FloatingActionButton(
              onPressed: _changeBottomAppBarVisible,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
    );
  }
}
