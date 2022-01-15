import 'package:epubx/epubx.dart';
import 'package:ereader/screens/ereader_screen/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/file_explorer/files.dart';
import 'package:ereader/file_explorer/ebook_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ereader/shared_data/shared_preferences.dart';

import '../../../shared_data/ereader_style.dart';

class EreaderBloc extends Bloc<EreaderEvent, EreaderState> {
  EreaderBloc() : super(const EbookLoading()) {
    on<LoadBook>(_loadBook);
  }

  Future _loadBook(LoadBook event, Emitter<EreaderState> emit) async {
    // final fileReadWrite = FileReadWrite(relativePath: 'ebooks');

    final selectedStyleMap =
        await SharedPreferenceTool.getMapPreferences('selectedStyle')
            as Map<String, dynamic>;
    final selectedStyle = EreaderStyle.fromJson(selectedStyleMap);

    final ebookRetrieval = EbookRetrieval();
    print('Path of opened book: ${event.ebookPath}');
    final ebook = await ebookRetrieval.getEbook(event.ebookPath);

    final title = ebook.Title ?? 'No title';
    final content = ebook.Content; // EpubContent

    if (content == null) {
      emit(EbookDisplay(
        title: title,
        content: 'No content',
        ereaderStyle: selectedStyle,
      ));
    } else {
      final htmlFiles = content.Html ?? <String?, EpubTextContentFile>{};

      final htmlList = <String>[];

      for (var htmlFile in htmlFiles.values) {
        htmlList.add(htmlFile.Content ?? '');
      }

      emit(EbookDisplay(
        title: title,
        content: htmlList.join(),
        ereaderStyle: selectedStyle,
      ));
    }
  }
}
