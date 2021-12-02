import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_security/flutter_security.dart';
import 'package:flutter_security/helpers/platform_options.dart';
import 'package:flutter_security/helpers/response_codes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _amItamperedResponse = 'Let me check';
  List<String?> _list = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    ResponseSecurityCodes amItampered;
    amItampered = await FlutterSecurity.amITampered(
      iosSecurityOptions: IosSecurityOptions(
          bundleId: 'com.example.flutterSecurityExample',
          mobileProvision: 'some_hash_values'),
      androidSecurityOptions: AndroidSecurityOptions(sha1: 'some_sha1_values'),
    );

    if (!mounted) return;

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      switch (amItampered) {
        case ResponseSecurityCodes.tampered:
          _amItamperedResponse = 'YES!!!';
          break;
        case ResponseSecurityCodes.notTampered:
          _amItamperedResponse = 'No.';
          break;
        case ResponseSecurityCodes.genericError:
          _amItamperedResponse = 'Unable to check, something goes wrong';
          break;
        case ResponseSecurityCodes.missingParametersError:
          _amItamperedResponse = 'Missing parameters';
          break;
        case ResponseSecurityCodes.unavailable:
          _amItamperedResponse = 'Unavailable';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Am I tampered?\n$_amItamperedResponse\n'),
              ElevatedButton(
                onPressed: () async {
                  final a = await FlutterSecurity.hasBundleBeenCompromised(
                    iosSecurityOptions: IosSecurityOptions(
                        bundleId: 'com.example.flutterSecurityExample',
                        jsonFileName: 'encrypted.json',
                        cryptographicKey: 'k4rAN45oL8LxH21wX2nRTDB5o1uYnnrB'),
                  );
                  print(a);
                  setState(() {});
                },
                child: Text('check'),
              ),
              SizedBox(
                height: 50,
              ),
              Text('LIST'),
              ..._list.map((e) => Text(e ?? '')).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
