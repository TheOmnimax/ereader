import 'package:equatable/equatable.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';

abstract class EreaderEvent extends Equatable {
  const EreaderEvent();

  @override
  List<Object> get props => [];
}

class LoadBook extends EreaderEvent {
  const LoadBook({required this.ebookPath});

  final String ebookPath;
}

class TurnPage extends EreaderEvent {
  const TurnPage({
    required this.toPage,
  });

  final int toPage;
}
