import 'dart:async';
import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:ereader/bloc/ereader_bloc.dart';
import 'package:ereader/utils/html_processor/ebook_utils/ebook_tool.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

// Method based on:
// https://github.com/sujanbhattaraiofficial/splitted-text/blob/main/lib/logic/splittedText.dart

class EreaderBloc extends Bloc<EreaderEvent, EreaderState> {
  EreaderBloc({
    required this.appBloc,
  }) : super(const EbookLoading()) {
    on<LoadBook>(_loadBook);
    on<WordSelected>(_showPopup);
  }

  final AppBloc appBloc;

  Future _loadBook(LoadBook event, Emitter<EreaderState> emit) async {
    final style = appBloc.state.currentStyle;

    final ebookFile = File(event.ebookPath);
    final ebookBytes = ebookFile.readAsBytesSync();
    final epubBook = await EpubReader.readBook(ebookBytes);
    final ebookProcessor = EbookProcessor(epubBook: epubBook);
    final margins = style.margins;
    final vertPadding = margins[0] + margins[2];
    final horizontalPadding = margins[1] + margins[3];
    print('Original width: ${event.workingWidth}');
    print('Original height: ${event.workingHeight}');
    final ebookData = ebookProcessor.getEbookData(
      pageHeight: event.workingHeight - vertPadding.toDouble(),
      pageWidth: event.workingWidth - horizontalPadding.toDouble(),
      style: style.toTextStyle(),
    );
    print('Got ebook data');
    final pages = ebookData.pageData;

    // print('Loading asset...');
    // final exampleContent =
    //     await rootBundle.loadString('assets/test_files/act-1 - Copy.xhtml');
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
      style: style,
    ));
    return;
  }

  void _showPopup(WordSelected event, Emitter<EreaderState> emit) {}
}
