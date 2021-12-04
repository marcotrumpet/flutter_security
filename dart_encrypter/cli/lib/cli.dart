import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/pointycastle.dart';

Future<Uint8List?> encrypt({required Uint8List file}) async {
  final key = 'k4rAN45oL8LxH21wX2nRTDB5o1uYnnrB';

  final keyy = Key.fromUtf8(key);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(keyy));

  final encrypted = encrypter.encrypt(String.fromCharCodes(file), iv: iv);

  return encrypted.bytes;
}

Future<Uint8List?> handleFile(String path) async {
  final file = File(path);
  if (!file.existsSync()) {
    exitCode = 1;
    print('File at $path not found.');
    return null;
  } else {
    return file.readAsBytesSync();
  }
}

Future<String?> getMD5fromFile(Uint8List file) async {
  try {
    final digestObject = Digest('MD5');
    final bytes = digestObject.process(file);

    final digest = HEX.encode(bytes);

    return digest;
  } catch (e) {
    print('Something went wrong during MD5 creation');
  }
}

void encryptAndSaveList(
    List<Map<String, String>> list, String directory) async {
  final mapString = json.encode(list);

  final fileToSaveIntList =
      await encrypt(file: Uint8List.fromList(mapString.codeUnits));

  if (fileToSaveIntList?.isEmpty ?? true) return;

  final fileToSave = File('$directory/encrypted.json');

  if (!fileToSave.existsSync()) {
    fileToSave.createSync(recursive: true);
  }
  fileToSave.writeAsBytesSync(Uint8List.fromList(fileToSaveIntList!));
}
