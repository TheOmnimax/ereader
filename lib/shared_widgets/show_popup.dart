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
