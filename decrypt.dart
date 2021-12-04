import 'dart:io';

import 'package:encrypt/encrypt.dart';

void main() async {
  final file =
      File('/Users/marcogaletta/Downloads/encrypted.json').readAsBytesSync();

  var keyString = 'k4rAN45oL8LxH21wX2nRTDB5o1uYnnrB';

  final key = Key.fromUtf8(keyString);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = Encrypted(file);

  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  final decryptedFileAsString = decrypted;
  print(decryptedFileAsString);
}
