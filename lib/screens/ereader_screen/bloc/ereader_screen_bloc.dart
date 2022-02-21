import 'package:epubx/epubx.dart';
import 'package:ereader/screens/ereader_screen/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/file_explorer/files.dart';
import 'package:ereader/file_explorer/ebook_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ereader/shared_data/shared_preferences.dart';

import '../../../shared_data/ereader_style.dart';
import 'package:ereader/screens/ereader_screen/ebook_processor/ebook_processor.dart';

class EreaderBloc extends Bloc<EreaderEvent, EreaderState> {
  EreaderBloc() : super(const EbookLoading()) {
    on<LoadBook>(_loadBook);
    on<TurnPage>(_turnPage);
  }

  Future<EbookProcessed> _processEbook(EpubBook epubBook) async {
    final ebookProcessor = EbookProcessor(epubBook: epubBook);
    final ebookProcessed = await ebookProcessor.runProcessor();

    return ebookProcessed;
  }

  Future _loadBook(LoadBook event, Emitter<EreaderState> emit) async {
    // final fileReadWrite = FileReadWrite(relativePath: 'ebooks');

    final ebookRetrieval = EbookRetrieval();
    print('Path of opened book: ${event.ebookPath}');
    final ebook = await ebookRetrieval.getEbook(event.ebookPath);

    final title = ebook.Title ?? 'No title';

    final ebookProcessed = await _processEbook(ebook);
    print('Processed ebook');

    emit(EbookDisplay(
      title: title,
      ebookProcessed: ebookProcessed,
    ));
  }

  Future _turnPage(TurnPage event, Emitter<EreaderState> emit) async {
    var newPage = event.toPage;
    if (newPage < 0) {
      newPage = 0;
    }
    print('Turning to page $newPage');

    emit(
      state.copyWith(
        newPosition: newPage,
      ),
    );
  }
}
