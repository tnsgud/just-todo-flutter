import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isBottomAppBarVisible = false;
  final FocusNode _textFieldFocusNode = FocusNode();

  void _changeBottomAppBarVisible() {
    setState(() {
      _isBottomAppBarVisible = !_isBottomAppBarVisible;
    });
  }

  Widget _customTextButton(
      {required String text, required VoidCallback action}) {
    return TextButton(
      onPressed: action,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Text(text),
    );
  }

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode.addListener(() {
      if (!_textFieldFocusNode.hasFocus) {
        _changeBottomAppBarVisible();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Colors.grey[800],
          floating: false,
          pinned: true,
          snap: false,
          expandedHeight: 100,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
          flexibleSpace: const FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              '계획된 할일',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(20, (idx) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Card(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  child: ListTile(
                    leading: const Icon(null),
                    title: Text('$idx'),
                    onTap: null,
                  ),
                ),
              );
            }),
          ),
        ),
      ], scrollDirection: Axis.vertical),
      // extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: true,
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         const Text(
      //           '계획된 일정',
      //           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      //         ),
      //         ListView.separated(
      //           scrollDirection: Axis.vertical,
      //           physics: const NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemBuilder: ((context, index) => Text('hello$index')),
      //           separatorBuilder: (context, index) => const Divider(),
      //           itemCount: 100,
      //         ),
      //         if (_isBottomAppBarVisible)
      //           TextField(
      //             autofocus: true,
      //             focusNode: _textFieldFocusNode,
      //           ),
      //       ],
      //     ),
      //   ),
      // ),
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
