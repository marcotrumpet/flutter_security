import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/pointycastle.dart';

Future<Uint8List?> encrypt({required Uint8List file, String? secretKey}) async {
  final key = (secretKey?.isNotEmpty ?? false)
      ? Key.fromUtf8(secretKey!)
      : Key.fromSecureRandom(32);

  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(String.fromCharCodes(file), iv: iv);

  return encrypted.bytes;
}

Future<Uint8List?> decrypt({required Uint8List file, String? secretKey}) async {
  final key = (secretKey?.isNotEmpty ?? false)
      ? Key.fromUtf8(secretKey!)
      : Key.fromSecureRandom(32);

  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = Encrypted(file);

  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  final decryptedFileAsUint8List = Uint8List.fromList(decrypted.codeUnits);

  return decryptedFileAsUint8List;
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
    List<Map<String, String>> list, String directory, String? secretKey) async {
  final mapString = json.encode(list);

  final fileToSaveIntList = await encrypt(
      file: Uint8List.fromList(mapString.codeUnits), secretKey: secretKey);

  if (fileToSaveIntList?.isEmpty ?? true) return;

  final fileToSave = File('$directory/encrypted.json');

  if (!fileToSave.existsSync()) {
    fileToSave.createSync(recursive: true);
  }
  fileToSave.writeAsBytesSync(Uint8List.fromList(fileToSaveIntList!));
}

void decryptAndSaveList(
    Uint8List file, String directory, String? secretKey) async {
  final fileToSaveIntList = await decrypt(file: file, secretKey: secretKey);

  if (fileToSaveIntList?.isEmpty ?? true) return;

  final fileToSave = File('$directory/decrypted.json');

  if (!fileToSave.existsSync()) {
    fileToSave.createSync(recursive: true);
  }
  fileToSave.writeAsBytesSync(Uint8List.fromList(fileToSaveIntList!));
}
