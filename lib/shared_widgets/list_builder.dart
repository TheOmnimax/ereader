import 'package:flutter/material.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({
    required this.widgets,
  });

  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    print('There are ${widgets.length} widgets');

    if (widgets.length == 0) {
      return Text('No styles!');
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

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int index) {
          return widgets[index];
        });
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    required this.mainButton,
    required this.backgroundColor,
    required this.kebabFunction,
  });

  final Widget mainButton;
  final Color backgroundColor;
  final Function kebabFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: mainButton,
          ),
          TextButton(
            style: TextButton.styleFrom(
                // maximumSize: Size.fromWidth(10.0),
                ),
            onPressed: () {},
            child: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
    );
  }
}
