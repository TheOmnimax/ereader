import 'dart:io';
import 'package:path/path.dart' as p;

class EbookStorage {}

class EbookRetrieval {
  // static Directory ebookDir = Directory('../ebook_files');
  // EbookRetrieval();
  //
  // void getEbooks() {
  //   var fileList = ebookDir.list(recursive: false);
  //   fileList.forEach((element) {
  //     print(element);
  //   });
  // }
}

void main() {
  // EbookRetrieval ebookRetrieval = EbookRetrieval();
  // ebookRetrieval.getEbooks();
  print(p.current);
}
