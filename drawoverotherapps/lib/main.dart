import 'package:drawoverotherapps/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draw over other apps',
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}
