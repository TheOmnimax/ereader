import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class EbookViewer extends StatelessWidget {
  const EbookViewer({
    this.htmlContent = '',
    this.ereaderStyle = const EreaderStyle(),
    Key? key,
  }) : super(key: key);

  final String htmlContent;
  final EreaderStyle ereaderStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ereaderStyle.backgroundColor,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ereaderStyle.margins[3].toDouble(),
          ereaderStyle.margins[0].toDouble(),
          ereaderStyle.margins[1].toDouble(),
          ereaderStyle.margins[2].toDouble(),
        ),
        child: Html(
          data: htmlContent,
          style: {
            'p': Style(
              color: ereaderStyle.fontColor,
              fontSize: FontSize(
                ereaderStyle.fontSize.toDouble(),
              ),
            )
          },
        ),
      ),
    );
  }
}
