import 'package:flutter/material.dart';

class WebHome extends StatefulWidget {
  const WebHome({super.key});

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final TextEditingController _searchTextFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.apps),
            ),
            const Spacer(),
            const Text('To Do'),
          ],
        ),
        title: SizedBox(
          width: 400,
          height: 32,
          child: TextField(
            cursorHeight: 20,
            textAlignVertical: TextAlignVertical.top,
            controller: _searchTextFieldController,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              suffixIcon: IconButton(
                  onPressed: () => _searchTextFieldController.clear(),
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.question_mark),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.campaign),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
              const Text('오늘 할 일')
            ],
          )
        ],
      ),
    );
  }
}
