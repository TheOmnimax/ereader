import 'package:flutter/material.dart';

Future<void> showPopup({
  required BuildContext context,
  required String title,
  required List<Widget> buttons,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            // TODO: Add parameter for custom dialogue
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: buttons,
      );
    },
  );
}
