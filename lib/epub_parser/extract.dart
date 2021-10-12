import 'package:flutter_archive/flutter_archive.dart';
import 'dart:io';

class FileRetriever {
  final String path;

  FileRetriever({required this.path});

  File getFile() {
    final file =
        File('lib/ebooks/grimms_fairy_tales-jacob_grimm_wilhelm_grimm.epub');
    return file;
  }
}

class Extractor {}
