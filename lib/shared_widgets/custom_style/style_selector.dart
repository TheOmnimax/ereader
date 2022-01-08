import 'package:flutter/material.dart';
import 'package:ereader/constants/constants.dart';

class StyleSelector extends StatelessWidget {
  const StyleSelector({
    required this.onTap,
    required this.selectedModule,
  });

  final Function(Module) onTap;
  final Module selectedModule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              StyleButton(
                name: kBackground,
                onTap: () {
                  onTap(Module.backgroundColor);
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
          ),
          Row(
            children: <Widget>[
              StyleButton(
                name: kFontFamily,
                onTap: () {
                  onTap(Module.fontFamily);
                },
                selected: selectedModule == Module.fontFamily,
              ),
              StyleButton(
                name: kMargins,
                onTap: () {
                  onTap(Module.margins);
                },
                selected: selectedModule == Module.margins,
              ),
              StyleButton(
                name: kName,
                onTap: () {
                  onTap(Module.name);
                },
                selected: selectedModule == Module.name,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StyleButton extends StatelessWidget {
  // TODO: Add return for StyleModules enum when tapped
  const StyleButton({
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
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.blueAccent : const Color(0xffdddddd),
            ),
            color: selected ? Colors.blue : Colors.white,
          ),
          child: Text(name),
        ),
      ),
    );
  }
}
