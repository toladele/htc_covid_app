import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheManager {
  Future<String> readCache() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      print(e);
      return "";
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/appt.txt');
  }

  Future<File> writeCache(var data) async {
    final file = await _localFile;
    return file.writeAsString('$data');
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        print("File already exists, deleting...");
        await file.delete();
      } else {
        print("File does not exist.");
      }
    } catch (e) {
      // Error in getting access to the file.
      print("File does not exist.");
    }
  }
}
