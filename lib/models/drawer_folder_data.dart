import 'package:flutter/material.dart';
import 'package:just_todo/models/drawer_item_data.dart';

class DrawerFolderData extends DrawerItemData {
  late List<DrawerItemData> list;

  DrawerFolderData({
    required IconData iconData,
    required Color color,
    required String title,
    required this.list,
  }) : super(
          iconData: iconData,
          color: color,
          title: title,
        );
}
