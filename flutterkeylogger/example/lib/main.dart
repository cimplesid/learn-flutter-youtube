import 'package:flutter/material.dart';
import 'package:flutterkeylogger/flutterkeylogger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    keyLogger.logs((a) {
      if (mounted) {
        log.add(a);
        setState(() {});
      }
    });
  }

  List<Log> log = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(
            children: [for (var item in log) Text(item.raw)],
          )),
    );
  }
}
