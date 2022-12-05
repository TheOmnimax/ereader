import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerImp {
  const FilePickerImp();

  Future<File?> get file async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path ?? '');
      return file;
    } else {
      // User canceled the picker
      return null;
    }
  }
}
