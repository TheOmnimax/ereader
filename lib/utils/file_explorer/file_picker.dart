import 'package:file_picker/file_picker.dart';
import 'dart:io';

class FilePickerImp {
  const FilePickerImp();

  Future<File?> get file async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var file = File(result.files.single.path ?? '');
      return file;
    } else {
// User canceled the picker
      return null;
    }
  }
}
