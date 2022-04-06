import '../html_processor.dart';
import 'package:epubx/epubx.dart';

class EbookData {
  const EbookData({
    required this.title,
    required this.author,
    this.authorList,
    required this.pageData,
    required this.chapterData,
  });

  final String title;
  final String author;
  final List<String?>? authorList;
  final List<PageData> pageData;
  final List<ChapterData>
      chapterData; // A list of the page indexes in "pageData" where each chapter starts, so the user can jump ahead to each chapter

  EbookData redoPages({
    required PageChapterData pageChapterData,
  }) {
    return EbookData(
      title: title,
      author: author,
      authorList: authorList,
      pageData: pageChapterData.pageData,
      chapterData: pageChapterData.chapterData,
    );
  }
}

class PageChapterData {
  const PageChapterData({
    required this.pageData,
    required this.chapterData,
  });

  final List<PageData> pageData;
  final List<ChapterData> chapterData;
}

class ChapterData {
  const ChapterData._({
    required this.title,
    required this.start,
    this.anchor,
  });

  final String title;
  final int start; // Page index where the chapter starts;
  final String? anchor;

  static ChapterData generate({
    required EpubChapter chapterData,
    required int start,
  }) {
    String title = chapterData.Title ?? '';
    String? anchor = chapterData.Anchor;
    return ChapterData._(
      title: title,
      start: start,
      anchor: anchor,
    );
  }
}
