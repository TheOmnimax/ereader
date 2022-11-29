import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    required this.onSelected,
    required this.itemList,
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  final Function(String) onSelected;
  final List<String> itemList;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      icon: Icon(
        Icons.more_vert,
        color: color,
      ),
      itemBuilder: (BuildContext context) {
        return createPopupMenuList(
          itemList: itemList,
        );
      },
    );
  }
}

List<PopupMenuItem<String>> createPopupMenuList({
  required List<String> itemList,
}) {
  return itemList.map((String choice) {
    return PopupMenuItem<String>(
      value: choice,
      child: Text(choice),
    );
  }).toList();
}
