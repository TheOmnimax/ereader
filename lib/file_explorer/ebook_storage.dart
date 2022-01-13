import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:epubx/epubx.dart';
import 'ebook_metadata.dart';
import 'package:ereader/constants/constants.dart';
import 'package:image/image.dart';

class EbookStorage {}

class EbookDefaults {
  static const String title = '[No title]';
  static const String author = '[Unknown]';
  static const List<String> authorList = <String>['[Unknown]'];
}

class EbookRetrieval {
  static Directory ebookDir = Directory(
    p.join(p.current, 'assets', 'ebook_files'),
  );
  EbookRetrieval() {
    print('current: ${p.current}');
    print('assets: ${Directory('assets').existsSync()}');
    print('media: ${Directory('media').existsSync()}');
    print('About to get path');
    final coverFilePath =
        File(p.join(p.current, 'assets', 'media', 'default_cover.png'));
    print('Got path');
    final coverFile = coverFilePath.readAsBytesSync();
    print('Processed file');
    defaultCover = decodeImage(coverFile);
    print('Decoded');
  }

  Image? defaultCover;

  Future<EpubBook> getEbook(String filePath) async {
    final targetFile = File(filePath);
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

  List<FileSystemEntity> getFileList() {
    return ebookDir.listSync().toList();
  }

  Future<List<EpubBook>> getEbooks() async {
    final ebookFiles = getFileList(); // List<FileSystemEntity>
    final ebookList = <EpubBook>[];
    await Future.forEach(ebookFiles, (FileSystemEntity filePath) async {
      final epubBook = await getEbook(filePath.path);
      ebookList.add(epubBook);
    });
    return ebookList;
  }

  Future<List<EbookMetadata>> getAllEbookMetadata() async {
    print('About to get file list');
    final ebookFiles = getFileList(); // List<FileSystemEntity>
    print('Retrieved file list');
    final ebookMetadataList = <EbookMetadata>[];
    await Future.forEach(ebookFiles, (FileSystemEntity filePath) async {
      final epubBook = await getEbook(filePath.path);
      final epubMetadata = EbookMetadata(
        title: epubBook.Title ?? EbookDefaults.title,
        author: EbookDefaults.author,
        coverImage: null,
        filePath: filePath.path,
      );
      ebookMetadataList.add(epubMetadata);
    });
    return ebookMetadataList;
  }
}

void main() async {
  EbookRetrieval ebookRetrieval = EbookRetrieval();
  print(await ebookRetrieval.getEbooks());
}
