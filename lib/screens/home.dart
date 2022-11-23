import 'package:flutter/material.dart';
import 'package:just_todo/components/search_field.dart';
import 'package:just_todo/responsive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _screens = [
      Container(color: Colors.red),
      Container(color: Colors.orange),
      Container(color: Colors.yellow),
      Container(color: Colors.green),
      Container(color: Colors.blue),
      Container(color: Colors.purple)
    ];
  }

  Widget drawerItem({
    required IconData iconData,
    required Color? color,
    required String title,
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
        SearchField(),
        drawerItem(
          iconData: Icons.sunny,
          color: Colors.blueGrey[200],
          title: '오늘 할 일',
          index: 0,
        ),
        drawerItem(
          iconData: Icons.star_border,
          color: Colors.pink[200],
          title: '중요',
          index: 1,
        ),
        drawerItem(
          iconData: Icons.calendar_today,
          color: Colors.cyan[200],
          title: '계획된 일정',
          index: 2,
        ),
        drawerItem(
          iconData: Icons.person_outline,
          color: Colors.cyan,
          title: '나에게 할당됨',
          index: 3,
        ),
        drawerItem(
          iconData: Icons.flag_outlined,
          color: Colors.red,
          title: '플래그가 지정된 전자 메일',
          index: 4,
        ),
        drawerItem(
          iconData: Icons.home_outlined,
          color: Colors.deepPurple[200],
          title: '작업',
          index: 5,
        ),
        const Divider(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: todoDrawer(),
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
