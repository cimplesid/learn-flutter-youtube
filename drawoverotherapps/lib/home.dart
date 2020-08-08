import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {},
            color: Colors.green,
            child: Text('Show'),
          )
        ],
      ),
    );
  }
}
