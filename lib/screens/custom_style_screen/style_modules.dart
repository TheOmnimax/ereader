import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_bloc.dart';
import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_event.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/color_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StyleModules extends StatelessWidget {
  // TODO: Hide modules based on StyleModules enum
  const StyleModules({required this.visibleModule});

  final Module visibleModule;

  @override
  Widget build(BuildContext context) {
    final ereaderStyle =
        context.select((CustomStyleBloc bloc) => bloc.state.ereaderStyle);

    void updateStyle({
      Color? backgroundColor,
      Color? fontColor,
      int? fontSize,
      String? fontFamily,
      List<int>? margins,
    }) {
      backgroundColor ??= ereaderStyle.backgroundColor;
      fontColor ??= ereaderStyle.fontColor;
      fontSize ??= ereaderStyle.fontSize;
      fontFamily ??= ereaderStyle.fontFamily;
      margins ??= ereaderStyle.margins;

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
        Visibility(
          visible: visibleModule == Module.backgroundColor,
          child: ColorSelection(
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
        ),
      ],
    );
  }
}
