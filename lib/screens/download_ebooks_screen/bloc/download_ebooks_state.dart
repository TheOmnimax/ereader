import 'package:equatable/equatable.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:ereader/constants/constants.dart';

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

// TODO: Question: Is there an easier way to set up a state that is the same except for a few things?
// class DownloadExists extends ListBooks {
//   const DownloadExists({
//     required List<EbookMetadata> ebookList,
//     required this.filename,
//     required this.codeUnits,
//   }) : super(
//           ebookList: ebookList,
//           status: LoadingStatus.warning,
//           info: 'eBook already exists!',
//         );
//
//   final String filename;
//   final List<int> codeUnits;
//
//   @override
//   List<Object?> get props => [ebookList, status, info];
// }

// class Downloading extends DownloadEbooksState {
//   const Downloading({
//     required List<EbookMetadata> ebookList,
//   }) : super(ebookList: ebookList);
// }
