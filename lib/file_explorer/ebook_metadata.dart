// ignore_for_file: public_member_api_docs
import 'dart:io';
import 'package:epubx/epubx.dart';
import 'package:image/image.dart';

class EbookMetadata {
  final String title;
  final String author;
  final Image coverImage;

  const EbookMetadata(
      {required this.title, required this.author, required this.coverImage});
}

class EpubMetadataFactory {
  final EpubBook epubBook;

  EpubMetadataFactory({required this.epubBook});

  Image getDefaultCover() {
    final image = decodeJpg(File('test.jpg').readAsBytesSync());
    return image;
  }

  String getTitle() {
    return epubBook.Title ?? '[no title]';
  }

  String getAuthor() {
    return epubBook.Author ?? '[no author]';
  }

  Image getCover() {
    final cover = epubBook.CoverImage ??
        decodePng(File('test.jpg').readAsBytesSync()) ??
        Image(600, 900);
    return cover;
  }
}
