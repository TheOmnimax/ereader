import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.icon,
    required this.onChanged,
    this.selected = false,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final Function() onChanged;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor:
          selected ? Colors.blueAccent : const Color.fromARGB(0, 0, 0, 0),
      child: IconButton(
        onPressed: onChanged,
        icon: Icon(
          icon,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
