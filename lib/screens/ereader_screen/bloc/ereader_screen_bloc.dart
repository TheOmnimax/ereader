import 'dart:async';

import 'package:epubx/epubx.dart';
import 'package:ereader/utils/html_processor/ebook_utils/ebook_tool.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'bloc.dart';

// Method based on:
// https://github.com/sujanbhattaraiofficial/splitted-text/blob/main/lib/logic/splittedText.dart

class EreaderBloc extends Bloc<EreaderEvent, EreaderState> {
  EreaderBloc() : super(const EbookLoading()) {
    on<LoadBook>(_loadBook);
    on<WordSelected>(_showPopup);
  }

  Future _loadBook(LoadBook event, Emitter<EreaderState> emit) async {
    final style = event.style;

    print('Loading asset...');
    final ebookFile = File(event.ebookPath);
    final ebookBytes = ebookFile.readAsBytesSync();
    final epubBook = await EpubReader.readBook(ebookBytes);
    final ebookProcessor = EbookProcessor(epubBook: epubBook);
    final ebookData = ebookProcessor.getEbookData(
      pageHeight: event.workingHeight,
      pageWidth: event.workingWidth,
      style: style,
    );
    print('Got ebook data');
    final pages = ebookData.pageData;

    // final exampleContent =
    //     await rootBundle.loadString('assets/pooh_intro.xhtml');
    //
    // final pages = HtmlDisplayTool.getPages(
    //   htmlContent: exampleContent,
    //   pageHeight: event.workingHeight,
    //   pageWidth: event.workingWidth,
    //   defaultStyle: event.style,
    // );

    emit(EbookDisplay(
      // content: exampleContent,
      pages: pages,
      pageNum: 0,
    ));
    return;
  }

  void _showPopup(WordSelected event, Emitter<EreaderState> emit) {}
}
