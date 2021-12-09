import 'package:flutter/cupertino.dart';
import 'color_slider.dart';
import 'package:ereader/shared_data/ereader_style.dart';

class StyleModules extends StatelessWidget {
  const StyleModules({required this.ereaderStyle});

  final EreaderStyle ereaderStyle;

  @override
  Widget build(BuildContext context) {
    void updateStyle(
      Color? backgroundColor,
      Color? fontColor,
      int? fontSize,
      String? fontFamily,
      List<int>? margins,
    ) {
      if (backgroundColor == null) {}

      context.read<CustomStyleBloc>().add(
            UpdateStyle(
              backgroundColor: backgroundColor,
              fontColor: fontColor,
              fontSize: fontSize,
              fontFamily: fontFamily,
              margins: margins,
            ),
          );
    }

    return Column(
      children: <Widget>[
        ColorSelection(
          onChange: (Color color) {
            updateStyle(
              backgroundColor: color,
              fontColor: ereaderStyle.fontColor,
              fontSize: ereaderStyle.fontSize,
              fontFamily: ereaderStyle.fontFamily,
              margins: ereaderStyle.margins,
            );
          },
          color: ereaderStyle.backgroundColor,
        ),
      ],
    );
  }
}
