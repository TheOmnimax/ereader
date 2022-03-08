import 'package:equatable/equatable.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';

abstract class EbookSelectionState extends Equatable {
  const EbookSelectionState({
    this.ebookList = const <EbookMetadata>[],
    this.username = '',
  });

  final List<EbookMetadata> ebookList;
  final String username;

  @override
  List<Object?> get props => [];
}

class EbookSelectionLoading extends EbookSelectionState {
  const EbookSelectionLoading();


}

class EbookSelectionMainState extends EbookSelectionState {
  const EbookSelectionMainState({
    List<EbookMetadata> ebookList = const <EbookMetadata>[],
    String username = '',
  }) : super(ebookList: ebookList, username: username);

  @override
  List<Object?> get props => [ebookList, username];

  @override
  EbookSelectionMainState copyWith({
    List<EbookMetadata>? ebookList,
    String? username,
  }) {
    return EbookSelectionMainState(
      ebookList: ebookList ?? this.ebookList,
      username: username ?? this.username,
    );
  }
}
