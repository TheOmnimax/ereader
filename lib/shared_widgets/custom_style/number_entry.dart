import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiNumberEntry extends StatelessWidget {
  const MultiNumberEntry({
    this.values = const [12, 12, 12, 12],
    this.unit,
    this.arrowChange = 1,
    required this.onChangedFunctions,
    Key? key,
  }) : super(key: key);

  final List<int> values;
  final String? unit;
  final int arrowChange;
  final List<Function(int)> onChangedFunctions;

  List<Widget> getNumberEntryList() {
    final numberEntryList = <Widget>[];

    final numEntries = onChangedFunctions.length;
    for (var n = 0; n < numEntries; n++) {
      final onChanged = onChangedFunctions[n];
      final value = values[n];
      numberEntryList.add(SingleNumberEntry(
        onChanged: onChanged,
        value: value,
        unit: unit,
        arrowChange: arrowChange,
      ));
    }
    return numberEntryList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getNumberEntryList(),
    );
  }
}

class SingleNumberEntry extends StatelessWidget {
  SingleNumberEntry({
    Key? key,
    this.value = 12,
    this.unit,
    this.arrowChange = 1,
    required this.onChanged,
    this.defaultValue = 12,
  }) : super(key: key);

  final int value;
  final String? unit;
  final int arrowChange;
  final Function(int) onChanged;
  final int defaultValue;

  final tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (value == defaultValue) {
      tc
        ..text = defaultValue.toString()
        ..selection = TextSelection(
            baseOffset: 0, extentOffset: defaultValue.toString().length);
    } else {
      tc
        ..text = value.toString()
        ..selection = TextSelection(
            baseOffset: tc.text.length, extentOffset: tc.text.length);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: tc,
            enableSuggestions: false,
            // initialValue: value.toString(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              // onChanged(value);
              // return;
              final valDouble = num.tryParse(value);
              if (valDouble == null) {
                onChanged(defaultValue);
              } else {
                onChanged(valDouble.toInt());
              }
            },
            textAlign: TextAlign.center,
          ),
        ),
        if (unit != null) Text(' $unit'),
        Column(
          children: [
            IconButton(
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.arrow_upward),
              onPressed: () {
                onChanged(value + arrowChange);
              },
              padding: EdgeInsets.zero,
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
