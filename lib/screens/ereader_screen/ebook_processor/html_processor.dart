import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:ereader/utils/file_explorer/ebook_storage.dart';
import 'package:ereader/screens/ereader_screen/ebook_processor/ebook_processor.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:epubx/epubx.dart';

class EbookHtmlProcessor {
  EbookHtmlProcessor({
    required this.content,
  });

  final String content;
  List elements = <dynamic>[]; // Will update type

  void printContent() {
    print(content);
  }

  // TextSpan _processElement(Node element) {
  //   List
  // }
  //
  // List _processChildren(Node node) {
  //   for (var child in node.childNodes) {
  //     if (child.hasChildNodes()) {
  //
  //     }
  //   }
  // }

  List<Widget> getContentWidgets() {
    elements = <dynamic>[];

    final widgetList = <Widget>[];

    final document = parse(content);

    final body = document.body;

    final bodyChildren = body?.children;

    for (var child in bodyChildren!) {
      var outerHtml = child.outerHtml;
      print(child.localName);
      // print(outerHtml);
      // if ()
    }

    return widgetList;
  }
}

void test() async {
  print('Running test...');
  // var ebookContent = await rootBundle.load(
  // 'assets/test_files/smith,adam-wealth_of_nations,the-000001-0000-0000.epub');
  final exampleContent =
      await rootBundle.loadString('assets/test_files/example.xhtml');
  // var bytes = ebookContent.buffer.asUint8List();
  // final epubBook = await EpubReader.readBook(bytes);
  //
  // final ebookProcessor = EbookProcessor(epubBook: epubBook);
  // final processedEbook = await ebookProcessor.runProcessor();
  final ebookHtmlProcessor = EbookHtmlProcessor(content: exampleContent)
    ..getContentWidgets();
}
