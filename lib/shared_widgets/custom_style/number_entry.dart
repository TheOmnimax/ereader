import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleNumberEntry extends StatelessWidget {
  const SingleNumberEntry({
    this.value = 12,
    this.unit,
    this.arrowChange = 1,
    required this.onChanged,
  });

  final int value;
  final String? unit;
  final int arrowChange;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    print('Received value: $value');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 50,
          child: TextFormField(
            initialValue: value.toString(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              try {
                onChanged(double.parse(value).toInt());
              } catch (e) {
                onChanged(12);
              }
            },
            textAlign: TextAlign.center,
          ),
        ),
        if (unit != null) Text(' $unit'),
        Column(
          children: [
            IconButton(
              onPressed: () {
                onChanged(value + arrowChange);
              },
              icon: const Icon(Icons.arrow_upward),
            ),
            IconButton(
              onPressed: () {
                onChanged(value - arrowChange);
              },
              icon: const Icon(Icons.arrow_downward),
            ),
          ],
        )
      ],
    );
  }
}
