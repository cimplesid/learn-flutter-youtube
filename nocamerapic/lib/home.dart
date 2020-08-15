import 'dart:io';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final File image;

  const Home({Key key, this.image}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    widget.image,
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          Text('Access granted')
        ],
      ),
    );
  }
}
