import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:epubx/epubx.dart';

class EbookStorage {}

class EbookRetrieval {
  static Directory ebookDir = Directory(p.join(p.current, 'lib', 'ebooks'));
  EbookRetrieval();

  Future<EpubBook> getEbook(String filePath) async {
    final targetFile = File(filePath);
    final List<int> bytes = await targetFile.readAsBytes();
    final epubBook = await EpubReader.readBook(bytes);
    return epubBook;
  }

  Future<List<EpubBook>> getEbooks() async {
    final ebookFiles = ebookDir.listSync().toList(); // List<FileSystemEntity>
    final ebookList = <EpubBook>[];
    await Future.forEach(ebookFiles, (FileSystemEntity filePath) async {
      final epubBook = await getEbook(filePath.path);
      ebookList.add(epubBook);
    });
    return ebookList;
  }
}

void main() async {
  EbookRetrieval ebookRetrieval = EbookRetrieval();
  print(await ebookRetrieval.getEbooks());
}
