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
    return Container(
      height: 140,
      color: ereaderStyle.backgroundColor,
      child: SingleChildScrollView(
        child: Text(
          kSampleText,
          style: TextStyle(
            color: ereaderStyle.fontColor,
            fontSize: ereaderStyle.fontSize.toDouble(),
          ),
        ),
      ),
    );
    // width: double.infinity,);
  }
}
