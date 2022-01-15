import 'package:equatable/equatable.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';
import 'package:epubx/epubx.dart';
import 'package:ereader/shared_data/ereader_style.dart';

abstract class EreaderState extends Equatable {
  const EreaderState();

  @override
  List<Object?> get props => [];
}

class EbookLoading extends EreaderState {
  const EbookLoading();
}

class EbookDisplay extends EreaderState {
  const EbookDisplay({
    required this.title,
    required this.content,
    this.ereaderStyle = const EreaderStyle(),
  });

  final String title;
  final String content;
  final EreaderStyle ereaderStyle;
}
