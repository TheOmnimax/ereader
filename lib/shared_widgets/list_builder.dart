import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder(
      {required this.widgets, this.missingWarning = 'None found!'});

  final List<Widget> widgets;
  final String missingWarning;

  @override
  Widget build(BuildContext context) {
    print('There are ${widgets.length} widgets');

    if (widgets.length == 0) {
      return Text(missingWarning);
    }
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      // padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return widgets[index];
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Color(0xffc4c4c4),
        height: 8,
        thickness: 2,
      ),
      itemCount: widgets.length,
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    required this.mainButton,
    required this.kebabFunction,
    required this.itemList,
    this.backgroundColor = Colors.white,
    this.kebabColor = Colors.black,
  });

  final Widget mainButton;
  final Color backgroundColor;
  final Function(String) kebabFunction;
  final List<String> itemList;
  final Color kebabColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: mainButton,
          ),
          PopupMenu(
            color: kebabColor,
            onSelected: kebabFunction,
            itemList: itemList,
          ),
        ],
      ),
    );
  }
}
