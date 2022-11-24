import 'package:flutter/material.dart';
import 'package:just_todo/components/default_todo_screen.dart';
import 'package:just_todo/components/icon_text_field.dart';
import 'package:just_todo/models/drawer_item_data.dart';
import 'package:just_todo/models/todo.dart';
import 'package:just_todo/responsive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex;
  late List<DefaultTodoScreen> _screens;
  late List<DrawerItemData> _drawerItemList;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
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
    _screens = [
      ..._drawerItemList
          .map((e) => DefaultTodoScreen(
              primaryColor: e.color, title: e.title, list: const []))
          .toList(),
    ];
  }

  Widget drawerItem({
    required IconData iconData,
    required Color? color,
    required String title,
    required int count,
    required int index,
  }) {
    return ListTile(
      onTap: () => setState(() {
        _currentIndex = index;
      }),
      leading: Icon(
        iconData,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: count != 0 ? Text('$count') : null,
    );
  }

  Widget todoDrawer() {
    return Column(
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
        ),
        ..._drawerItemList.map(
          (e) => drawerItem(
            iconData: e.iconData,
            color: e.color,
            title: e.title,
            count: _screens[_drawerItemList.indexOf(e)].count,
            index: _drawerItemList.indexOf(e),
          ),
        ),
        const Divider(
          color: Colors.white,
          height: 2,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: _screens[_currentIndex],
            )
          ],
        ),
      ),
    );
  }
}
