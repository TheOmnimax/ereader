import 'dart:io';
import 'package:epubx/epubx.dart';
import 'package:ereader/utils/file_explorer/ebook_metadata.dart';
import 'package:ereader/utils/file_explorer/files.dart';
import 'package:flutter/material.dart' as material;

class EbookStorage {}

class EbookDefaults {
  static const String title = '[No title]';
  static const List<String> author = ['[Unknown]'];
  static const List<String> authorList = <String>['[Unknown]'];
}

class EbookRetrieval {
  EbookRetrieval() {
    getDefaultCover();
  }

  Image? defaultCover;

  // TODO: Implement
  Future<void> getDefaultCover() async {
    const defaultCover = material.AssetImage('assets/media/default_cover.png');
  }

  Future<EpubBook> getEbook(String filePath) async {
    final targetFile = File(filePath);
    final List<int> bytes = await targetFile.readAsBytes();
    final epubBook = await EpubReader.readBook(bytes);

    // TODO: Add default content

    return epubBook;
  }

  Future<List<EbookMetadata>> getAllEbookMetadata() async {
    const fileRetrieval = FileReadWrite(relativePath: 'ebooks');
    await fileRetrieval.createDir();

    final ebookFiles = await fileRetrieval.getFilesInFolder();

    // TODO: Check each file, and make sure it is a valid epub file.

    final ebookMetadataList = <EbookMetadata>[];
    await Future.forEach(ebookFiles, (FileSystemEntity filePath) async {
      final epubBook = await getEbook(filePath.path);
      final epubMetadata = EbookMetadata(
        title: epubBook.Title ?? EbookDefaults.title,
        authors: epubBook.AuthorList ?? EbookDefaults.author,
        coverImage: null,
        filePath: filePath.path,
      );
      ebookMetadataList.add(epubMetadata);
    });
    return ebookMetadataList;
  }
}

// void main() async {
//   EbookRetrieval ebookRetrieval = EbookRetrieval();
//   print(await ebookRetrieval.getEbooks());
// }
