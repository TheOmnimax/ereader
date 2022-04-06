import 'dart:async';

import 'package:epubx/epubx.dart';
import 'package:ereader/utils/html_processor/ebook_utils/ebook_tool.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';

// Method based on:
// https://github.com/sujanbhattaraiofficial/splitted-text/blob/main/lib/logic/splittedText.dart

class EreaderBloc extends Bloc<EreaderEvent, EreaderState> {
  EreaderBloc() : super(const EbookLoading()) {
    on<LoadBook>(_loadBook);
    on<WordSelected>(_showPopup);
  }

  Future _loadBook(LoadBook event, Emitter<EreaderState> emit) async {
    var url =
    Uri.parse('https://url-shortener-344201.uc.r.appspot.com/your-url');
    final response = await http.post(url, body: {
      'url': 'https://google.com/',
      'code': 'google',
    });
    print(response.statusCode);
    print(response.body);

    final style = event.style;

    print('Loading asset...');
    final ebookRaw = await rootBundle
        .load('assets/milne,a._a.-winnie_the_pooh-000004-0000-0000.epub');
    // https://stackoverflow.com/questions/50119676/how-to-write-a-bytedata-instance-to-a-file-in-dart
    print('Converting...');
    final ebookBytes = ebookRaw.buffer.asUint8List();
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
