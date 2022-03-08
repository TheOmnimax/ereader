import 'package:equatable/equatable.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:epubx/epubx.dart';
import 'package:ereader/shared_data/ereader_style.dart';

import 'package:ereader/screens/ereader_screen/ebook_processor/ebook_processor.dart';

abstract class EreaderState extends Equatable {
  const EreaderState({
    this.title = 'No title',
    this.ebookProcessed = const EbookProcessed(),
    this.position = 0,
  });

  final String title;
  final EbookProcessed ebookProcessed;
  final int position;

  @override
  List<Object?> get props => [];

  EreaderState copyWith({
    String? newTitle,
    EbookProcessed? newEbookProcessed,
    int? newPosition,
  });
}

class EbookLoading extends EreaderState {
  const EbookLoading();

  @override
  EbookLoading copyWith({
    String? newTitle,
    EbookProcessed? newEbookProcessed,
    int? newPosition,
  }) {
    return const EbookLoading();
  }
}

class EbookDisplay extends EreaderState {
  const EbookDisplay({
    required this.title,
    required this.ebookProcessed,
    this.position = 0,
  });

  final String title;
  final EbookProcessed ebookProcessed;
  final int position;

  @override
  List<Object?> get props => [position];

  @override
  EbookDisplay copyWith({
    String? newTitle,
    EreaderStyle? newEreaderStyle,
    EbookProcessed? newEbookProcessed,
    int? newPosition,
  }) {
    return EbookDisplay(
      title: newTitle ?? title,
      ebookProcessed: newEbookProcessed ?? ebookProcessed,
      position: newPosition ?? position,
    );
  }
}
