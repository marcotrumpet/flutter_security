import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_security/flutter_security.dart';
import 'package:flutter_security/helpers/response_codes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _amItamperedResponse;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    ResponseSecurityCodes amItampered;
    // Platform messages may fail, so we use a try/catch PlatformException.
    amItampered = await FlutterSecurity.amITampered;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

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
          child: Text('Am I tampered?\n$_amItamperedResponse\n'),
        ),
      ),
    );
  }
}
