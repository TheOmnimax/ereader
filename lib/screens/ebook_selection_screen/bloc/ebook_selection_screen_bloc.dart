import 'dart:io';

import 'package:ereader/file_explorer/ebook_metadata.dart';
import 'package:ereader/file_explorer/ebook_storage.dart';
import 'package:ereader/file_explorer/file_picker.dart';
import 'package:ereader/file_explorer/files.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ebook_selection_screen_event.dart';
import 'ebook_selection_screen_state.dart';

class EbookSelectionBloc
    extends Bloc<EbookSelectionEvent, EbookSelectionState> {
  EbookSelectionBloc() : super(const EbookSelectionLoading()) {
    on<LoadPage>(_loadPage);
    on<GetNewEbook>(_getNewEbook);
    on<DeleteEbook>(_deleteEbook);
  }

  Future<List<EbookMetadata>> _getEbookMetadata() async {
    final ebookRetrieval = EbookRetrieval();

    final ebookMetadataList = await ebookRetrieval.getAllEbookMetadata();

    return ebookMetadataList;
  }

  Future<void> _deleteEbook(
      DeleteEbook event, Emitter<EbookSelectionState> emit) async {
    final filePath = event.deletePath;
    await File(filePath).delete();
    final ebookMetadataList = await _getEbookMetadata();
    emit(EbookSelectionMainState(
      ebookList: ebookMetadataList,
    ));
  }

  Future<void> _loadPage(
    LoadPage event,
    Emitter<EbookSelectionState> emit,
  ) async {
    final ebookMetadataList = await _getEbookMetadata();
    emit(EbookSelectionMainState(
      ebookList: ebookMetadataList,
    ));
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
