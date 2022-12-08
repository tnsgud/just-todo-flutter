import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_todo/components/default_todo_screen.dart';
import 'package:just_todo/components/icon_text_field.dart';
import 'package:just_todo/models/drawer_folder_data.dart';
import 'package:just_todo/models/drawer_item_data.dart';
import 'package:just_todo/responsive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DefaultTodoScreen _screen;
  late List<DrawerItemData> _drawerItemList;
  late List<DrawerItemData> _customDrawerItemList;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _drawerItemList = [
      DrawerItemData(
        iconData: Icons.sunny,
        color: Colors.blueGrey[200]!,
        title: '오늘 할 일',
      ),
      DrawerItemData(
        iconData: Icons.star_border,
        color: Colors.pink[200]!,
        title: '중요',
      ),
      DrawerItemData(
        iconData: Icons.calendar_today,
        color: Colors.cyan[200]!,
        title: '계획된 일정',
      ),
      DrawerItemData(
        iconData: Icons.person_outline,
        color: Colors.cyan,
        title: '나에게 할당됨',
      ),
      DrawerItemData(
        iconData: Icons.flag_outlined,
        color: Colors.red,
        title: '플래그가 지정된 전자 메일',
      ),
      DrawerItemData(
        iconData: Icons.home_outlined,
        color: Colors.deepPurple[200]!,
        title: '작업',
      )
    ];

    for (var data in _drawerItemList) {
      data.screen =
          DefaultTodoScreen(primaryColor: data.color, title: data.title);
    }
    _customDrawerItemList = [];

    _screen = _drawerItemList[0].screen ??
        const DefaultTodoScreen(primaryColor: Colors.red, title: '빈 페이지');
  }

  Widget drawerFolderItem({required DrawerFolderData data}) {
    return DragTarget<DrawerItemData>(
      builder: (context, candidateData, rejectedData) => ExpansionTile(
        leading: Icon(
          data.iconData,
          color: Colors.teal,
        ),
        title: Text(
          data.title.replaceAll('', '\u{200B}'),
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        children: data.list.map((e) => drawerItem(data: e)).toList(),
      ),
      onAccept: (sentData) {
        data.list.add(sentData);

        setState(() {
          _customDrawerItemList.remove(sentData);
        });
      },
      onLeave: (leaveData) {
        data.list.remove(leaveData);
      },
    );
  }

  Widget drawerItem({
    required DrawerItemData data,
  }) {
    return Draggable<DrawerItemData>(
      data: data,
      feedback: Container(),
      child: ListTile(
        onTap: () {
          if (_scaffoldKey.currentState!.isDrawerOpen) {
            _scaffoldKey.currentState!.closeDrawer();
          }

          setState(() {
            _screen = data.screen!;
          });
        },
        leading: Icon(
          data.iconData,
          color: data.color,
        ),
        title: Text(
          data.title.replaceAll('', '\u{200B}'),
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget todoDrawer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                    'https://pbs.twimg.com/profile_images/1374979417915547648/vKspl9Et_400x400.jpg'),
              ),
              title: const Text('qkrtnsgud'),
              subtitle: const Text('qkrtnsgud029'),
            ),
            IconTextField(
              fillColor: Colors.grey[850]!,
              hintText: '검색',
              icon: Icons.search,
              iconColor: Colors.white,
              onEditingComplete: () {},
            ),
            ..._drawerItemList.map(
              (e) => drawerItem(data: e),
            ),
            const Divider(
              color: Colors.white,
              height: 2,
            ),
            ..._customDrawerItemList.map(
              (e) => e is DrawerFolderData
                  ? drawerFolderItem(data: e)
                  : drawerItem(data: e),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () {
                var title = '제목 없는 목록';
                var count = _customDrawerItemList
                    .where((element) => element.title.contains(title))
                    .length;

                title = '$title${count == 0 ? "" : " $count"}';
                var screen = DefaultTodoScreen(
                  primaryColor: Colors.teal,
                  title: title,
                );
                var item = DrawerItemData(
                  iconData: Icons.list,
                  color: Colors.teal,
                  title: title,
                  screen: screen,
                );

                setState(() {
                  _customDrawerItemList.add(item);
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('새 목록'),
            ),
            IconButton(
              onPressed: () {
                var title = '제목 없는 목록';
                var count = _customDrawerItemList
                    .where((element) => element.title.contains(title))
                    .length;
                var item = DrawerFolderData(
                  list: [],
                  iconData: Icons.folder_rounded,
                  color: Colors.teal,
                  title: '$title${count == 0 ? "" : " $count"}',
                );

                setState(() {
                  _customDrawerItemList.add(item);
                });
              },
              icon: const Icon(Icons.create_new_folder_rounded),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
      key: _scaffoldKey,
      appBar: Responsive.isDesktop(context) ? null : AppBar(),
      drawer: Responsive.isDesktop(context) ? null : todoDrawer(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: Container(
                  color: Theme.of(context).primaryColorDark,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: todoDrawer(),
                  ),
                ),
              ),
            Expanded(
              flex: 5,
              child: _screen,
            )
          ],
        ),
      ),
    );
  }
}
