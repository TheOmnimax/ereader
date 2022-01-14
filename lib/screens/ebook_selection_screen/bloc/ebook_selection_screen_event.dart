import 'package:equatable/equatable.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';

abstract class EbookSelectionEvent extends Equatable {
  const EbookSelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadPage extends EbookSelectionEvent {
  const LoadPage();
}

class PageLoaded extends EbookSelectionEvent {
  const PageLoaded();
}

class EbookSelected extends EbookSelectionEvent {
  const EbookSelected({
    required this.ebookMetadata,
  });

  final EbookMetadata ebookMetadata;
}

class GetNewEbook extends EbookSelectionEvent {
  const GetNewEbook();
}
