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
      color: ereaderStyle.backgroundColor,
      child: Text(
        kSampleText,
        style: TextStyle(
          color: ereaderStyle.fontColor,
        ),
      ),
    );
    // width: double.infinity,);
  }
}
