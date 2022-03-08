import 'package:equatable/equatable.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';

class DownloadEbookState extends Equatable {
  const DownloadEbookState({
    required this.ebookList,
  });

  final List<EbookMetadata> ebookList;

  @override
  List<Object?> get props => [ebookList];

  DownloadEbookState copyWith({
    List<EbookMetadata>? ebookList,
  }) {
    return DownloadEbookState(
      ebookList: ebookList ?? this.ebookList,
    );
  }
}
