import 'package:equatable/equatable.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/utils/html_processor/html_processor.dart';

abstract class EreaderState extends Equatable {
  const EreaderState({
    // this.content = '',
    this.pages = const <PageData>[],
    this.pageNum = 0,
  });

  // final String content;
  final List<PageData> pages;
  final int pageNum;

  @override
  List<Object?> get props => [];

  EreaderState copyWith({
    // String? content,
    List<PageData>? pages,
    int? pageNum,
  });
}

class EbookInitial extends EreaderState {
  const EbookInitial();

  @override
  EreaderState copyWith({
    // String? content,
    List<PageData>? pages,
    int? pageNum,
  }) {
    return EbookInitial();
  }
}

class EbookLoading extends EreaderState {
  const EbookLoading({
    this.content = '',
  });

  final String content;
  @override
  EbookLoading copyWith({
    // String? content,
    List<PageData>? pages,
    int? pageNum,
  }) {
    return const EbookLoading();
  }
}

class EbookDisplay extends EreaderState {
  const EbookDisplay({
    // required this.content,
    required this.pages,
    required this.pageNum,
    required this.style,
  });

  // final String content;
  final List<PageData> pages;
  final int pageNum;
  final EreaderStyle style;

  @override
  List<Object?> get props => [pages, pageNum, style];

  @override
  EbookDisplay copyWith({
    // String? content,
    List<PageData>? pages,
    int? pageNum,
    EreaderStyle? style,
  }) {
    return EbookDisplay(
      // content: content ?? this.content,
      pages: pages ?? this.pages,
      pageNum: pageNum ?? this.pageNum,
      style: style ?? this.style,
    );
  }
}
