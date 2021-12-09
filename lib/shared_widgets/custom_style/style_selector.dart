import 'package:flutter/material.dart';
import 'package:ereader/constants/constants.dart';

class StyleSelector extends StatelessWidget {
  const StyleSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        StyleButton(
          name: kBackground,
        ),
        StyleButton(
          name: kFontColor,
        ),
        StyleButton(
          name: kFontSize,
        ),
      ],
    );
  }
}

class StyleButton extends StatelessWidget {
  // TODO: Add return for StyleModules enum when tapped
  const StyleButton({
    required this.name,
    this.selected = false,
  });

  final String name;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.blueAccent : const Color(0x00000000),
          ),
          color: selected ? Colors.blue : Colors.white,
        ),
        child: Text(name),
      ),
    );
  }
}
