import 'package:equatable/equatable.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';

abstract class DownloadEbooksState extends Equatable {
  const DownloadEbooksState({
    this.ebookList = const <EbookMetadata>[],
    this.status = LoadingStatus.working,
    this.info = 'No status',
  });
  final List<EbookMetadata> ebookList;
  final LoadingStatus status;
  final String info;

  @override
  List<Object?> get props => [ebookList, status, info];

  DownloadEbooksState copyWith({
    List<EbookMetadata>? ebookList,
    LoadingStatus? status,
    String? info,
  });
}

class InitialState extends DownloadEbooksState {
  const InitialState();

  @override
  List<Object?> get props => [];

  @override
  InitialState copyWith({
    List<EbookMetadata>? ebookList,
    LoadingStatus? status,
    String? info,
  }) {
    return const InitialState();
  }
}

class NoLogin extends DownloadEbooksState {
  const NoLogin();

  @override
  NoLogin copyWith({
    List<EbookMetadata>? ebookList,
    LoadingStatus? status,
    String? info,
  }) {
    return const NoLogin();
  }
}

class ListBooks extends DownloadEbooksState {
  const ListBooks({
    required List<EbookMetadata> ebookList,
    LoadingStatus status = LoadingStatus.ready,
    String info = 'Ready!',
  }) : super(
          ebookList: ebookList,
          status: status,
          info: info,
        );

  @override
  List<Object?> get props => [ebookList, status, info];

  @override
  ListBooks copyWith({
    List<EbookMetadata>? ebookList,
    LoadingStatus? status,
    String? info,
  }) {
    return ListBooks(
      ebookList: ebookList ?? this.ebookList,
      status: status ?? this.status,
      info: info ?? this.info,
    );
  }
}
