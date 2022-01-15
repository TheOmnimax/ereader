import 'package:equatable/equatable.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';

abstract class EbookSelectionState extends Equatable {
  const EbookSelectionState({
    this.ebookList = const <EbookMetadata>[],
  });

  final List<EbookMetadata> ebookList;

  @override
  List<Object?> get props => [];

  EbookSelectionState copyWith({
    List<EbookMetadata>? newEbookList,
  });
}

class EbookSelectionLoading extends EbookSelectionState {
  const EbookSelectionLoading();

  @override
  EbookSelectionLoading copyWith({
    List<EbookMetadata>? newEbookList,
  }) {
    return const EbookSelectionLoading();
  }
}

class EbookSelectionMainState extends EbookSelectionState {
  const EbookSelectionMainState({
    this.ebookList = const <EbookMetadata>[],
  });

  // TODO: It is both asking me to override and not to override. Why?
  final List<EbookMetadata> ebookList;

  @override
  List<Object?> get props => [ebookList];

  EbookSelectionMainState copyWith({
    List<EbookMetadata>? newEbookList,
  }) {
    return EbookSelectionMainState(
      ebookList: newEbookList ?? ebookList,
    );
  }
}
