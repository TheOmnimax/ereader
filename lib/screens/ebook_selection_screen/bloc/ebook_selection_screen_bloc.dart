import 'package:ereader/file_explorer/ebook_metadata.dart';
import 'package:flutter/cupertino.dart';

import 'ebook_selection_screen_event.dart';
import 'ebook_selection_screen_state.dart';
import 'package:ereader/file_explorer/ebook_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/shared_widgets/list_builder.dart';
import 'package:ereader/file_explorer/file_picker.dart';
import 'package:ereader/file_explorer/files.dart';

class EbookSelectionBloc
    extends Bloc<EbookSelectionEvent, EbookSelectionState> {
  EbookSelectionBloc() : super(const EbookSelectionLoading()) {
    on<LoadPage>(_loadPage);
    on<GetNewEbook>(_getNewEbook);
  }

  Future<List<EbookMetadata>> _getEbookMetadata() async {
    final ebookRetrieval = EbookRetrieval();

    final ebookMetadataList = await ebookRetrieval.getAllEbookMetadata();

    return ebookMetadataList;
  }

  Future<void> _loadPage(
    LoadPage event,
    Emitter<EbookSelectionState> emit,
  ) async {
    final ebookMetadataList = await _getEbookMetadata();
    print(ebookMetadataList);

    emit(EbookSelectionMainState(
      ebookList: ebookMetadataList,
    ));

    // final ebookWidgetList = <Widget>[];
    //
    // for (final ebookMetadata in ebookMetadataList) {
    //   ebookWidgetList.add(EbookListItem(
    //     ebookMetadata: ebookMetadata,
    //   ));
    // }
  }

  Future<void> _getNewEbook(
    GetNewEbook event,
    Emitter<EbookSelectionState> emit,
  ) async {
    var newBook = false;
    const filePicker = FilePickerImp();
    final newFile = await filePicker.file;

    if (newFile != null) {
      const fileReadWrite = FileReadWrite(relativePath: 'ebooks');
      newBook = await fileReadWrite.addFile(newFile);
      if (newBook) {
        final ebookMetadataList = await _getEbookMetadata();
        emit(EbookSelectionMainState(ebookList: ebookMetadataList));
      } else {
        emit(state.copyWith());
      }
    } else {
      emit(state.copyWith());
    }
  }
}
