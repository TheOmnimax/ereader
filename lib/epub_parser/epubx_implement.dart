import 'dart:io';
import 'package:epubx/epubx.dart';

class EpubImplement {
  EpubImplement({required this.filePath});
  final String filePath;

  Future<EpubBook> getEpub() async {
    final targetFile = File(filePath);
    final List<int> bytes = await targetFile.readAsBytes();
    final epubBook = await EpubReader.readBook(bytes);
    return epubBook;
  }
}
