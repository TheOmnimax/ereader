import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileReadWrite {
  const FileReadWrite({
    this.relativePath = '',
  });

  final String relativePath;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<bool> createDir() async {
    final path = await _localPath;
    final newPath = Directory(p.join(path, relativePath));
    if (newPath.existsSync()) {
      return false;
    } else {
      await newPath.create();
      return true;
    }
  }

  Future<Directory> get mainDir async {
    final path = await _localPath;
    return Directory(p.join(path, relativePath));
  }

  Future<List<FileSystemEntity>> getFilesInFolder() async {
    final dir = await mainDir;
    print('Retrieving files from ${dir.path}');
    final fileList = dir.list().toList();
    return fileList;
  }

  Future<bool> addFile(File file) async {
    final dir = await mainDir;
    await createDir();
    final fileName = p.basename(file.path);
    final newFile = await file.copy(p.join(dir.path, fileName));
    await newFile.create();
    print('New file: $newFile');
    final successful = newFile.existsSync();
    print('Successful: $successful');
    return successful;
  }
}
