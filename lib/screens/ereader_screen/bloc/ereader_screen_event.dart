import 'package:equatable/equatable.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';

abstract class EreaderEvent extends Equatable {
  const EreaderEvent();

  @override
  List<Object> get props => [];
}

// class LoadScreen extends EreaderEvent {
//   const LoadScreen({})
// }

class LoadBook extends EreaderEvent {
  const LoadBook({
    required this.ebookPath,
    required this.widgetHeight,
  });

  final String ebookPath;
  final double widgetHeight;
}

class TurnPage extends EreaderEvent {
  const TurnPage({
    required this.toPage,
  });

  final int toPage;
}
