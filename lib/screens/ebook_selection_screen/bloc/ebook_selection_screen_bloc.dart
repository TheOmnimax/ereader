import 'package:flutter/cupertino.dart';

import 'ebook_selection_screen_event.dart';
import 'ebook_selection_screen_state.dart';
import 'package:ereader/file_explorer/ebook_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/shared_widgets/list_builder.dart';

class EbookSelectionBloc
    extends Bloc<EbookSelectionEvent, EbookSelectionState> {
  EbookSelectionBloc() : super(const EbookSelectionLoading()) {
    on<LoadPage>(_loadPage);
  }

  Future<void> _loadPage(
    LoadPage event,
    Emitter<EbookSelectionState> emit,
  ) async {
    var ebookRetrieval = EbookRetrieval();

    final ebookMetadataList = await ebookRetrieval.getAllEbookMetadata();
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
}
