import 'package:equatable/equatable.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';

abstract class EbookSelectionState extends Equatable {
  const EbookSelectionState({
    this.ebookList = const <EbookMetadata>[],
    this.username = '',
  });

  final List<EbookMetadata> ebookList;
  final String username;

  @override
  List<Object?> get props => [];

  EbookSelectionState copyWith({
    List<EbookMetadata>? ebookList,
    String username,
  });
}

class EbookSelectionLoading extends EbookSelectionState {
  const EbookSelectionLoading();

  @override
  EbookSelectionLoading copyWith({
    // TODO: Is this the best way to set this up, even though the parameters are not used?
    List<EbookMetadata>? ebookList,
    String? username,
  }) {
    return const EbookSelectionLoading();
  }
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
