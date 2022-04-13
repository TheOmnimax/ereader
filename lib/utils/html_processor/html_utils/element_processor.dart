import 'package:flutter/gestures.dart';
import 'package:html/dom.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'helper_classes.dart';
import '../../text_span_table/text_span_table.dart';

class ElementProcessor {
  ElementProcessor({
    required this.document,
  });

  final html.Document document;
  static const _lineBreakTags = [
    'p',
    'tr',
    'title',
    'h2',
    'h3',
  ];

  html.NodeList eliminateWhitespace(html.NodeList nodeList) {
    if (nodeList[0].nodeType == 3) {
      nodeList[0].text = nodeList[0].text?.replaceAll(RegExp(r'^[ \n]+'), '');
    }

    if (nodeList[nodeList.length - 1].nodeType == 3) {
      nodeList[nodeList.length - 1].text = nodeList[nodeList.length - 1]
          .text
          ?.replaceAll(RegExp(r'[ \n]+$'), '');
    }

    return nodeList;
  }

  // Adds style to TextStyle based on the styles found in the "style" attribute of the HTML tag. Done up here for organization.
  TextStyle _applyStyle({
    TextStyle currentStyle = const TextStyle(),
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

  Map<String, String> _mapStyle(String styleString) {
    Map<String, String> styleMap = <String, String>{};
    List<String> parts = styleString.split(new RegExp(r';[ \n]*'));
    for (var part in parts) {
      List<String> styleParts = part.split(new RegExp(r':[ \n]*'));
      styleMap[styleParts[0]] = styleParts[1];
    }

    return styleMap;
  }

  TextSpan _nodeProcessor({
    required html.NodeList nodes,
    required List<html.Element> elements,
    List<String> parents = const <String>[],
    String elementTag = '',
    TextStyle? spanStyle,
  }) {
    var onElement = 0;
    TextStyle? nextStyle;

    final children = <TextSpan>[];
    var lastTag = '';
    final String identifier;
    for (final node in nodes) {
      nextStyle = null;
      switch (node.nodeType) {
        case (1):
          {
            // Element node
            final element = elements[onElement];
            onElement++;
            final tagName = element.localName ?? '';

            var addLineBreak = false;

            if (_lineBreakTags.contains(tagName)) {
              nodes = eliminateWhitespace(nodes);
              addLineBreak = true;
            }

            switch (tagName) {
              case '':
                {
                  break;
                }
              case 'p':
                {
                  children.add(TextSpan(text: '    '));
                  break;
                }
              case 'table':
                {
                  break;
                }
              case 'tr':
                {
                  break;
                }
              case 'td':
                {
                  break;
                }
              case 'title':
                {
                  break;
                }
              case 'h2':
                {
                  break;
                }
              case 'h3':
                {
                  break;
                }
              case 'br':
                {
                  children.add(TextSpan(text: '\n'));
                  break;
                }
              default:
                {
                  break;
                }
            }

            final attributes = node.attributes;
            for (var attribute in attributes.keys) {
              switch (attribute) {
                case 'style':
                  {
                    Map<String, String> styleMap =
                        _mapStyle(attributes[attribute] ?? '');
                    if (spanStyle == null) {
                      nextStyle = _applyStyle(
                        styleMap: styleMap,
                      );
                    } else {
                      nextStyle = _applyStyle(
                        currentStyle: spanStyle,
                        styleMap: styleMap,
                      );
                    }
                    break;
                  }
                case 'href':
                  {}
              }
            }

            children.add(_nodeProcessor(
              nodes: node.nodes,
              elements: node.children,
              parents: parents + [tagName],
              elementTag: tagName,
              spanStyle: nextStyle,
            ));

            switch (tagName) {
              case 'td':
                {
                  children.add(TextSpan(text: '    '));
                }
            }

            if (addLineBreak) {
              for (final tag in _lineBreakTags) {
                if (parents.contains(tag)) {
                  addLineBreak = false;
                  break;
                }
              }
            }
            if (addLineBreak) {
              // Element needs to be followed by a linebreak, but there is not already a line break scheduled
              children.add(TextSpan(text: '\n'));
            }
            lastTag = tagName;
            break;
          }
        case (3):
          {
            children.add(TextSpan(text: node.text));
            lastTag = '';
            break;
          }
      } // End SWITCH through node type
    } // End FOR through each node
    // return _processElement(workingNode: document);
    return TextSpan(
      // text: elementTag,
      children: children,
      style: spanStyle,
    );
  }

  TextSpan runProcessor() {
    return _nodeProcessor(
      nodes: document.nodes,
      elements: document.children,
    );
  }
}
