// ignore_for_file: public_member_api_docs
import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:flutter/material.dart';
import 'dart:async';

// part 'ebook_metadata.g.dart';

// TODO: Update with author and publisher list
class EbookMetadata {
  const EbookMetadata({
    required this.title,
    required this.authors,
    required this.coverImage,
    this.filePath = '',
  });

  EbookMetadata.fromEpub(EpubBook epubBook)
      : title = epubBook.Title ?? '[no title]',
        authors = epubBook.AuthorList ?? ['[no author]'],
        coverImage = epubBook.CoverImage ??
            decodePng(File('test.jpg').readAsBytesSync()) ??
            Image(600, 900),
        filePath = '';

  EbookMetadata.fromMap(Map<String, dynamic> data)
      : title = data['title'] as String,
        authors = data['authors'] as List<String?>,
        coverImage =
            decodePng(File('test.jpg').readAsBytesSync()) ?? Image(600, 900),
        filePath = data['publishers'].toString();

  EbookMetadata.fromJsonGen(GenEbookMetadata data)
      : title = data.title,
        authors = data.authors,
        coverImage = decodePng(
                File('assets/media/default_cover.png').readAsBytesSync()) ??
            Image(600, 900),
        filePath = data.filePath;

  static Future<EbookMetadata> fromServerJson(Map<String, dynamic> json) async {
    final title = json['title'] as String;
    final authorsRaw = json['authors'] as List;
    final authors = <String>[];
    for (final author in authorsRaw) {
      authors.add(author as String);
    }
    final coverImageData =
        await rootBundle.load('assets/media/default_cover.png');
    final coverImage = decodeImage(coverImageData.buffer.asUint8List());

    final filePath = json['filename'] as String;
    return EbookMetadata(
        title: title,
        authors: authors,
        coverImage: coverImage,
        filePath: filePath);
  }
  // : title = json['title'] as String,
  //   authors = json['authors'] as List<String>,
  //   coverImage =
  //       decodePng(File('test.jpg').readAsBytesSync()) ?? Image(600, 900),
  //   filePath = json['filename'] as String;

  final String title;
  final List<String?> authors;
  final Image? coverImage;
  final String filePath;

  String authorList() {
    return authors.join(', ');
  }
}

@JsonSerializable()
class GenEbookMetadata {
  const GenEbookMetadata({
    required this.title,
    required this.authors,
    required this.publishers,
    required this.filePath,
  });

  // factory GenEbookMetadata.fromJson(Map<String, dynamic> json) =>
  //     _$GenEbookMetadataFromJson(json);

  final String title;
  final List<String?> authors;
  final List<String?> publishers;
  final String filePath;
}

// @JsonSerializable()
// class EbookMetadataJsonList {
//   const EbookMetadataJsonList({
//     required this.gemList,
//   });
//
//   final List<GenEbookMetadata> gemList;
//
//   factory EbookMetadataJsonList.fromJson(List<dynamic> json) =>
//       _$EbookMetadataJsonListFromJson(json);
// }
