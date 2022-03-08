import 'package:ereader/screens/download_ebook_screen/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';

class DownloadEbookBloc extends Bloc<DownloadEbookEvent, DownloadEbookState> {
  DownloadEbookBloc()
      : super(const DownloadEbookState(
          ebookList: <EbookMetadata>[],
        )) {
    on<LoadPage>(_loadPage);
  }

  Future _loadPage(LoadPage event, Emitter<DownloadEbookState> emit) async {}
}
