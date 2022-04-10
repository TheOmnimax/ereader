import 'package:flutter/gestures.dart';
import 'package:html/dom.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'helper_classes.dart';

// Used by HtmlDisplayTool to take the elements, and create a list of text spans and such.
class ElementProcessor {
  ElementProcessor({
    required this.topElement,
  });

  List<TextSpan> textSpanList = <TextSpan>[];
  List<WordChunk> wordChunks = <WordChunk>[];
  String plainText = '';
  final html.Element topElement;

  // Takes a string in a "style" HTML attribute, and turns it into a map so the list of styles in easily retrievable
  Map<String, String> _mapStyle(String styleString) {
    Map<String, String> styleMap = <String, String>{};
    List<String> parts = styleString.split(new RegExp(r';[ \n]*'));
    for (var part in parts) {
      List<String> styleParts = part.split(new RegExp(r':[ \n]*'));
      styleMap[styleParts[0]] = styleParts[1];
    }

    return styleMap;
  }

  // Adds style to TextStyle based on the styles found in the "style" attribute of the HTML tag. Done up here for organization.
  TextStyle _applyStyle({
    required TextStyle currentStyle,
    required Map<String, String> styleMap,
  }) {
    for (var style in styleMap.keys) {
      final styleValue = styleMap[style];
      switch (style) {
        case 'font-style':
          {
            switch (styleValue) {
              case 'italic':
                {
                  currentStyle = currentStyle.copyWith(
                    fontStyle: FontStyle.italic,
                  );
                  break;
                }
            }
            break;
          } // Font style
        case 'font-weight':
          {
            if (styleValue == 'bold') {
              currentStyle = currentStyle.copyWith(
                fontWeight: FontWeight.bold,
              );
            } else if (styleValue == 'normal') {
              currentStyle = currentStyle.copyWith(
                fontWeight: FontWeight.normal,
              );
            } else if (styleValue == 'bolder') {
              currentStyle = currentStyle.copyWith(
                fontWeight: FontWeight.w700,
              );
            } else if (styleValue == 'lighter') {
              currentStyle = currentStyle.copyWith(
                fontWeight: FontWeight.w300,
              );
            } else {
              final boldNum = num.tryParse(styleValue!);
              if (boldNum != null) {
                if (boldNum > 900) {
                  currentStyle = currentStyle.copyWith(
                    fontWeight: FontWeight.w900,
                  );
                } else {
                  currentStyle = currentStyle.copyWith(
                    fontWeight: FontWeight.values[boldNum ~/ 100],
                  );
                }
              }
            }
            break;
          } // Font weight
      }
    }
    return currentStyle.copyWith();
  }

  void _processElement({
    required html.Node element,
    TextStyle currentStyle = const TextStyle(),
    String workingTag = '',
  }) {
    var nodes = element.nodes;
    var elements = element.children;
    var onElement = 0;

    bool addLineBreak = false;
    switch (workingTag) {
      case '':
      case 'p':
        {
          // while (nodes[0].nodeType == 3) {
          //   if (RegExp(r'^ +$').hasMatch(nodes[0].text ?? '')) {
          //     nodes.removeAt(0);
          //   } else {
          //     // TODO: Find way to remove spaces between p tags without removing them within p's.
          //     // nodes[0].text = nodes[0].text?.trim();
          //     break;
          //   }
          // }
          // while (nodes[nodes.length - 1].nodeType == 3) {
          //   if (RegExp(r'^ +$').hasMatch(nodes[nodes.length - 1].text ?? '')) {
          //     nodes.removeAt(nodes.length - 1);
          //   } else {
          //     nodes[nodes.length - 1].text =
          //         nodes[nodes.length - 1].text?.trim();
          //     break;
          //   }
          // }
          addLineBreak = true;
          break;
        }
      case 'h2':
        {
          addLineBreak = true;
          break;
        }
      case 'br':
        {
          addLineBreak = true;
          break;
        }
      default:
        {
          break;
        }
    }

    for (var node in nodes) {
      TextStyle spanStyle = currentStyle;

      switch (node.nodeType) {
        case 1:
          {
            var workingElement = elements[onElement];
            workingTag = workingElement.localName ?? '';
            var attributes = workingElement.attributes;

            for (var attribute in attributes.keys) {
              switch (attribute) {
                case 'style':
                  {
                    Map<String, String> styleMap =
                        _mapStyle(attributes[attribute] ?? '');
                    spanStyle = _applyStyle(
                        currentStyle: spanStyle, styleMap: styleMap);
                    break;
                  }
                case 'href':
                  {}
              }
            }
            // TODO: This is a pretty messy way to do this. Is there a better way?
            onElement++;

            _processElement(
                element: node, currentStyle: spanStyle, workingTag: workingTag);

            break;
          }
        case 3:
          {
            var thisSpan = TextSpan(
              text: node.text,
              style: spanStyle,
              // recognizer: new TapGestureRecognizer()
              //   ..onTap = () => print(node.text),
            );
            textSpanList.add(thisSpan);
            wordChunks.add(
              WordChunk.buildWordChunk(
                textSpan: thisSpan,
              ),
            );
            plainText += ' ${node.text}';
            break;
          }
      }
    }

    if (addLineBreak) {
      // print('Adding line break');
      const lineBreakSpan = TextSpan(text: '\n');
      wordChunks.add(
        WordChunk.buildWordChunk(
          textSpan: lineBreakSpan,
        ),
      );
      textSpanList.add(lineBreakSpan);
      plainText += '\n';
    }
  } // END PROCESS ELEMENT

  void runProcessor() {
    _processElement(element: topElement);
  }
}
