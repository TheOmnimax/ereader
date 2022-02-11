import 'package:flutter/material.dart';

class PageTurner extends StatelessWidget {
  const PageTurner({
    Key? key,
    required this.child,
    required this.onLeft,
    required this.onRight,
  }) : super(key: key);

  final Widget child;
  final Function() onLeft;
  final Function() onRight;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: child,
      onTapUp: (TapUpDetails details) {
        final x = details.localPosition.dx;
        final y = details.localPosition.dy;
        if (x < width / 2) {
          print('Left');
          onLeft();
        } else {
          print('Right');
          onRight();
        }
      },
    );
  }
}
