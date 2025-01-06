import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class CacheService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _cacheFile async {
    final path = await _localPath;
    return File('$path/user_data.json');
  }

  Future<void> writeCache(Map<String, dynamic> data) async {
    final file = await _cacheFile;
    file.writeAsString(json.encode(data));
  }

  Future<Map<String, dynamic>?> readCache() async {
    try {
      final file = await _cacheFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return json.decode(contents);
      }
      return null;
    } catch (e) {
      print('Error reading cache: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    final file = await _cacheFile;
    if (await file.exists()) {
      await file.delete();
    }
  }
}
