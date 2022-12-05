import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:ereader/utils/html_processor/ebook_utils/ebook_classes.dart';
import 'package:flutter/cupertino.dart';

class EbookProcessor {
  const EbookProcessor({
    required this.epubBook,
  });

  final EpubBook epubBook;

  static Future<EbookProcessor> fromPath(String path) async {
    final epubBook = await getEpubBook(path);
    return EbookProcessor(epubBook: epubBook);
  }

  static Future<EpubBook> getEpubBook(String path) async {
    final targetFile = File(path);
    final List<int> bytes = await targetFile.readAsBytes();
    final epubBook = await EpubReader.readBook(bytes);
    return epubBook;
  }

  EbookData getEbookData({
    required double pageHeight,
    required double pageWidth,
    required TextStyle style,
    String altTitle = '[unknown title]',
    String altAuthor = '[unknown author]',
  }) {
    final pageChapterData = getPages(
      pageHeight: pageHeight,
      pageWidth: pageWidth,
      style: style,
    );
    return EbookData(
      title: epubBook.Title ?? altTitle,
      author: epubBook.Author ?? altAuthor,
      authorList: epubBook.AuthorList,
      pageData: pageChapterData.pageData,
      chapterData: pageChapterData.chapterData,
    );
  }

  PageChapterData getPages({
    required double pageHeight,
    required double pageWidth,
    required TextStyle style,
  }) {
    final pageGenerator = PageGenerator(
      epubBook: epubBook,
      pageWidth: pageWidth,
      pageHeight: pageHeight,
      style: style,
    )..generate();

    return PageChapterData(
      pageData: pageGenerator.pages,
      chapterData: pageGenerator.chapterData,
    );
  }
}
