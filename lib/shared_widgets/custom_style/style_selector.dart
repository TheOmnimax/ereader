import 'package:flutter/material.dart';
import 'package:ereader/constants/constants.dart';

class StyleSelector extends StatelessWidget {
  StyleSelector({
    required this.onTap,
    required this.selectedModule,
  });

  final Function(Module) onTap;
  final Module selectedModule;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        StyleButton(
          name: kBackground,
          onTap: () {
            onTap(Module.backgroundColor);
            print('Background');
          },
          selected: selectedModule == Module.backgroundColor,
        ),
        StyleButton(
          name: kFontColor,
          onTap: () {
            onTap(Module.fontColor);
          },
          selected: selectedModule == Module.fontColor,
        ),
        StyleButton(
          name: kFontSize,
          onTap: () {
            onTap(Module.fontSize);
          },
          selected: selectedModule == Module.fontSize,
        ),
      ],
    );
  }
}

class StyleButton extends StatelessWidget {
  // TODO: Add return for StyleModules enum when tapped
  StyleButton({
    required this.name,
    required this.onTap,
    this.selected = false,
  });

  final String name;
  final bool selected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.blueAccent : const Color(0x00000000),
            ),
            color: selected ? Colors.blue : Colors.white,
          ),
          child: Text(name),
        ),
      ),
    );
  }
}
