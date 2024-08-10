import 'dart:convert';
import 'package:auth_flutter/core/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Prefs {
  static const _storage = FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: Constants.DB_NAME,
      publicKey: Constants.DB_NAME,
    ),
  );

  static String textToBase64(String text) {
    return base64.encode(utf8.encode(text));
  }

  static String base64ToText(String text) {
    return utf8.decode(base64.decode(text));
  }

  static Future writeSecureData({
    required String key,
    required String value,
  }) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  static Future readSecureData({required String key}) async {
    var readData = await _storage.read(key: key);
    return readData;
  }

  static Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}
