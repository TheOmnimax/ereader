import 'package:equatable/equatable.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';

abstract class DownloadEbooksState extends Equatable {
  const DownloadEbooksState();
}

class InitialState extends DownloadEbooksState {
  const InitialState();

  @override
  List<Object?> get props => [];
}

class Ready extends DownloadEbooksState {
  const Ready();

  @override
  List<Object?> get props => [];
}

class ListBooks extends DownloadEbooksState {
  const ListBooks({
    required this.ebookList,
  });

  final List<EbookMetadata> ebookList;

  @override
  List<Object?> get props => [ebookList];
}
