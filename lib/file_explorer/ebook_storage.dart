import 'dart:io';
import 'package:epubx/epubx.dart';
import 'package:ereader/file_explorer/ebook_metadata.dart';
import 'package:ereader/file_explorer/files.dart';
import 'package:flutter/material.dart' as material;
import 'package:path/path.dart' as p;

class EbookStorage {}

class EbookDefaults {
  static const String title = '[No title]';
  static const String author = '[Unknown]';
  static const List<String> authorList = <String>['[Unknown]'];
}

class EbookRetrieval {
  EbookRetrieval() {
    getDefaultCover();
  }

  Image? defaultCover;

  Future<void> getDefaultCover() async {
    print('current: ${p.current}');
    print('assets: ${Directory('assets').existsSync()}');
    print('media: ${Directory('media').existsSync()}');
    print('About to get path');
    final defaultCover =
        const material.AssetImage('assets/media/default_cover.png');
    print('Decoded');
  }

  Future<EpubBook> getEbook(String filePath) async {
    final targetFile = File(filePath);
    print('About to get book at $filePath');
    final List<int> bytes = await targetFile.readAsBytes();
    final epubBook = await EpubReader.readBook(bytes);

    // epubBook.Title ??= 'title';
    // epubBook.Author ??= '[Unknown]';
    // epubBook.AuthorList ??= ['[Unknown]'];
    // epubBook.CoverImage ??= defaultCover;
    // TODO: Add default content
    // epubBook.Content ??= EpubContent(HTML);

    return epubBook;
  }

  // Future<List<EpubBook>> getEbooks() async {
  //   final ebookFiles = await getFileList(); // List<FileSystemEntity>
  //   final ebookList = <EpubBook>[];
  //   await Future.forEach(ebookFiles, (FileSystemEntity filePath) async {
  //     print('Path: ${filePath.path}');
  //     final epubBook = await getEbook(filePath.path);
  //     print(epubBook);
  //     ebookList.add(epubBook);
  //   });
  //   return ebookList;
  // }

  Future<List<EbookMetadata>> getAllEbookMetadata() async {
    const fileRetrieval = FileReadWrite(relativePath: 'ebooks');
    await fileRetrieval.createDir();

    final ebookFiles = await fileRetrieval.getFilesInFolder();

    // TODO: Check each file, and make sure it is a valid epub file.

    print('Retrieved file list. There are ${ebookFiles.length} items');
    final ebookMetadataList = <EbookMetadata>[];
    await Future.forEach(ebookFiles, (FileSystemEntity filePath) async {
      print('Path: ${filePath.path}');
      final epubBook = await getEbook(filePath.path);
      final epubMetadata = EbookMetadata(
        title: epubBook.Title ?? EbookDefaults.title,
        author: epubBook.Author ?? EbookDefaults.author,
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
