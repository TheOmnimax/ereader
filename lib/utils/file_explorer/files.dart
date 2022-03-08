import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileReadWrite {
  const FileReadWrite({
    this.relativePath = '',
    this.support = false,
  });

  final String relativePath;
  final bool support;

  Future<String> get _localPath async {
    final Directory directory;
    if (support) {
      directory = await getApplicationSupportDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

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

  Future<Directory> get _mainDir async {
    final path = await _localPath;
    return Directory(p.join(path, relativePath));
  }

  Future<List<FileSystemEntity>> getFilesInFolder() async {
    final dir = await _mainDir;
    print('Retrieving files from ${dir.path}');
    final fileList = dir.list().toList();
    return fileList;
  }

  Future<bool> addFile(File file) async {
    final dir = await _mainDir;
    await createDir();
    final fileName = p.basename(file.path);
    final newFile = await file.copy(p.join(dir.path, fileName));
    await newFile.create();
    print('New file: $newFile');
    final successful = newFile.existsSync();
    print('Successful: $successful');
    return successful;
  }

  Future<bool> addFileByName(String filename) async {
    final file = File(filename);
    final result = await addFile(file);
    return result;
  }

  Future<File> _getFileObject(String filename) async {
    final dir = await _mainDir;
    final path = p.join(dir.path, filename);
    final file = File(path);
    return file;
  }

  Future<String> getFileAsString(String filename, {bool create = false}) async {
    final file = await _getFileObject(filename);
    try {
      final fileData = file.readAsStringSync();
      return fileData;
    } on FileSystemException catch (e) {
      print('Error');
      if (e.message == 'Cannot open file') {
        file.createSync();
        print('Created file');
      } else {
        print(e);
      }
      return '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<Map<String, dynamic>> getFileAsMap(String filename,
      {bool create = false}) async {
    final stringData = await getFileAsString(filename, create: create);
    try {
      if (stringData == '') {
        return <String, dynamic>{};
      } else {
        final jsonData = jsonDecode(stringData) as Map<String, dynamic>;
        return jsonData;
      }
    } catch (e) {
      print('Error getting map data from $filename');
      return <String, dynamic>{};
    }
  }

  Future<List> getFileAsList(String filename, {bool create = false}) async {
    final stringData = await getFileAsString(filename, create: create);
    try {
      if (stringData == '') {
        return <dynamic>[];
      } else {
        final listData = jsonDecode(stringData) as List;
        return listData;
      }
    } catch (e) {
      print(e);
      print('Error getting list data from $filename');
      return <String>[];
    }
  }

  Future<bool> writeBytes({
    required String filename,
    required List<int> contents,
  }) async {
    final file = await _getFileObject(filename);
    try {
      file.writeAsBytesSync(contents);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> writeString({
    required String filename,
    required String contents,
  }) async {
    final file = await _getFileObject(filename);
    try {
      file.writeAsStringSync(contents);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
