import 'dart:io';

import 'package:ereader/screens/ebook_selection_screen/bloc/ebook_selection_screen_event.dart';
import 'package:ereader/screens/ebook_selection_screen/bloc/ebook_selection_screen_state.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:ereader/utils/file_explorer/ebook_storage.dart';
import 'package:ereader/utils/file_explorer/file_picker.dart';
import 'package:ereader/utils/file_explorer/files.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class EbookSelectionBloc
    extends Bloc<EbookSelectionEvent, EbookSelectionState> {
  EbookSelectionBloc() : super(const EbookSelectionLoading()) {
    on<LoadPage>(_loadPage);
    on<GetNewEbook>(_getNewEbook);
    on<DeleteEbook>(_deleteEbook);
    // on<LogOut>(_logOut);
  }

  final _auth = FirebaseAuth.instance;

  Future<List<EbookMetadata>> _getEbookMetadata() async {
    final ebookRetrieval = EbookRetrieval();

    final ebookMetadataList = await ebookRetrieval.getAllEbookMetadata();

    return ebookMetadataList;
  }

  Future<void> _deleteEbook(
    DeleteEbook event,
    Emitter<EbookSelectionState> emit,
  ) async {
    final filePath = event.deletePath;
    await File(filePath).delete();
    final ebookMetadataList = await _getEbookMetadata();
    emit(
      EbookSelectionMainState(
        ebookList: ebookMetadataList,
      ),
    );
  }

  Future<void> _loadPage(
    LoadPage event,
    Emitter<EbookSelectionState> emit,
  ) async {
    final user = _auth.currentUser;

    final ebookMetadataList = await _getEbookMetadata();
    emit(
      EbookSelectionMainState(
        ebookList: ebookMetadataList,
        username: user?.email ?? '',
      ),
    );
  }

  Future<void> _getNewEbook(
    GetNewEbook event,
    Emitter<EbookSelectionState> emit,
  ) async {
    const filePicker = FilePickerImp();
    final newFile = await filePicker.file;

    if (newFile != null) {
      const fileReadWrite = FileReadWrite(relativePath: 'ebooks');

      final filename = basename(newFile.path);
      await fileReadWrite.addFileByName(filename);

      final successCreate = await fileReadWrite.writeBytes(
        filename: filename,
        contents: newFile.readAsBytesSync(),
      );

      final ebookMetadataList = await _getEbookMetadata();
      emit(EbookSelectionMainState(ebookList: ebookMetadataList));
    } else {
      emit(state);
    }
  }

  // Future<void> _logOut(
  //   LogOut event,
  //   Emitter<EbookSelectionState> emit,
  // ) async {
  //   final _auth = FirebaseAuth.instance;
  //   try {
  //     await _auth.signOut();
  //     final currentUser = _auth.currentUser;
  //     if (currentUser == null) {
  //       emit(state.copyWith(
  //         username: '',
  //       ));
  //     } else {
  //       throw LogoutError('Failed to log out for unknown reason.');
  //     }
  //   } catch (e) {
  //     print(e);
  //     emit(state.copyWith());
  //   }
  // }
}

class LogoutError implements Exception {
  LogoutError(this.cause);
  String cause;
}
