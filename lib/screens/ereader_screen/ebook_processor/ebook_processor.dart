import 'package:epubx/epubx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/utils/file_explorer/ebook_storage.dart';

import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';

class EbookProcessor {
  EbookProcessor({
    required this.epubBook,
  });

  final EpubBook epubBook;

  Future<EbookProcessed> runProcessor() async {
    // TODO: Add chapter processor

    var parts = <String>[];

    final chapters = epubBook.Chapters;
    final rawContent = epubBook.Content;

    // if (chapters == null) {
    //
    // } else {
    //   for (final chapter in chapters) {
    //
    //   }
    //
    // }

    if (rawContent != null) {
      final contentHtml = rawContent.Html;
      if (contentHtml != null) {
        var numProcessed = 0;

        for (final key in contentHtml.keys) {
          final content = contentHtml[key]?.Content ?? '';
          print('Key: $key\n');
          parts.add(content);
          numProcessed++;
          print('Processed $numProcessed so far...');
        }
        print('Completing processing');
      }
    }
    return EbookProcessed(parts: parts);
  }
}

class EbookProcessed {
  const EbookProcessed({
    this.parts = const <String>[],
  });

  final List<String> parts;

  // TODO: Add alert when more parts of the ebook are ready for the viewer
}
