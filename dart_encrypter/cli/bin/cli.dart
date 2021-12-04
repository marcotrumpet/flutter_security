import 'dart:io';

import 'package:args/args.dart';
import 'package:cli/cli.dart';

void main(List<String> arguments) async {
  exitCode = 0;

  final argParser = ArgParser();
  final parser = argParser
    ..addOption(
      'file',
      abbr: 'f',
      help: 'Use this flag to pass a file',
    )
    ..addOption(
      'directory',
      abbr: 'd',
      help: 'Use this flag to pass a directory',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Set the output directory. Default to /',
      defaultsTo: '/',
    )
    ..addOption(
      'secret-key',
      help:
          'Set the secretKey used to encrypt or decrypt. In encryption method, default is a random secure key',
    )
    ..addFlag(
      'encrypt',
      abbr: 'e',
      help: 'Use this to encrypt file or folder',
      negatable: false,
    )
    ..addFlag(
      'decrypt',
      help: 'Use this to decrypt file or folder',
      negatable: false,
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show usage helper',
      negatable: false,
    );

  final results = parser.parse(arguments);

  if (results['help']) return print(parser.usage);

  if (results['file'] == null &&
      results['directory'] == null &&
      !results['help']) {
    return print('You must specify a file or a directory');
  }
  if (!results['encrypt'] && !results['decrypt']) {
    return print('Specify \'encrypt\' or \'decrypt\' option');
  }

  if (results['file'] != null && results['encrypt']) {
    final uint8listFile = await handleFile(results['file']);

    if (uint8listFile?.isEmpty ?? true) return;

    final md5 = await getMD5fromFile(uint8listFile!);

    if (md5?.isEmpty ?? true) return;

    final map = <String, String>{results['file']: md5!};

    encryptAndSaveList([map], results['directory'], results['secret-key']);
  }

  if (results['file'] != null && results['decrypt']) {
    final uint8listFile = await handleFile(results['file']);

    if (uint8listFile?.isEmpty ?? true) return;

    decryptAndSaveList(
        uint8listFile!, results['directory'], results['secret-key']);
  }
}
