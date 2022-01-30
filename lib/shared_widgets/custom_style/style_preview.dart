import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter/material.dart';

class StylePreview extends StatelessWidget {
  const StylePreview({
    required this.ereaderStyle,
  });

  final EreaderStyle ereaderStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ereaderStyle.backgroundColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            ereaderStyle.margins[3].toDouble(),
            ereaderStyle.margins[0].toDouble(),
            ereaderStyle.margins[1].toDouble(),
            ereaderStyle.margins[2].toDouble(),
          ),
          child: SingleChildScrollView(
            child: Text(
              kSampleText,
              style: TextStyle(
                color: ereaderStyle.fontColor,
                fontSize: ereaderStyle.fontSize.toDouble(),
              ),
            ),
          ),
        ),
      ),
    );
    // width: double.infinity,);
  }
}
