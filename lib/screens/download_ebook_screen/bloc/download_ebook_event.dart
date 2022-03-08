import 'package:equatable/equatable.dart';

abstract class DownloadEbookEvent extends Equatable {
  const DownloadEbookEvent();

  @override
  List<Object?> get props => [];
}

class LoadPage extends DownloadEbookEvent {
  const LoadPage();
}
