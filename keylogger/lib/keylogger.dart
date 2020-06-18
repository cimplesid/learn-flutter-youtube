import 'dart:async';

import 'package:flutter/services.dart';

class _Keylogger {
  static const _channel = const MethodChannel('keylogger');
  _Keylogger() {
    _channel.setMethodCallHandler((call) {
      String method = call.method;
      print("aaca");  
      if (method.contains("test")) {
        print(call.arguments);
      }
      return;
    });
  }
  int listnerCount = 0;
  Map<String, StreamSubscription<dynamic>> streams = {};
  getLog() async {
    await _channel.invokeMethod("test");
  }
  geta()async{
  print(  await _channel.invokeMethod("aaa"));

  }

  cancel() {
    streams.values.forEach((element) {
      element.cancel();
    });
  }
}

final keyLogger = _Keylogger();
