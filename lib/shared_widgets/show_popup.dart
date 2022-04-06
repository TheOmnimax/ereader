import 'package:flutter/material.dart';

Future<void> showPopup({
  required BuildContext context,
  required String title,
  required List<Widget> buttons,
  required Widget body,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: body,
        ),
        actions: buttons,
      );
    },
  );
}

OverlayEntry overlayPopup({
  required double screenWidth,
  double top = 0,
  double width = 200,
  Widget child = const Text(
    'No options available!',
    style: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
  ),
}) {
  final left = (screenWidth - width) / 2;

  return OverlayEntry(
    builder: (BuildContext context) {
      return Positioned(
        left: left,
        top: top,
        width: width,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: child,
          ),
        ),
      );
    },
  );
}
