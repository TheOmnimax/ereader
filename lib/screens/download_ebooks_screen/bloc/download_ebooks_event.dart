import 'package:equatable/equatable.dart';

abstract class DownloadEbooksEvent extends Equatable {
  const DownloadEbooksEvent();
}

class InitialLoad extends DownloadEbooksEvent {
  const InitialLoad();

  @override
  List<Object?> get props => [];
}

class GetEbookList extends DownloadEbooksEvent {
  const GetEbookList();

  @override
  List<Object?> get props => [];
}

class DownloadEbook extends DownloadEbooksEvent {
  const DownloadEbook({
    required this.filename,
  });

  final String filename;

  @override
  List<Object?> get props => [filename];
}
