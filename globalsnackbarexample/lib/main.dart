import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global snackbar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Global snackbar demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Global snackbar example',
              style: Theme.of(context).textTheme.headline1,
            ),
            Spacer(),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Page2()));
              },
              child: Text('Navigate'),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ScaffoldMessengerState scaffoldMessengerState =
              ScaffoldMessenger.of(context);
          await Future.delayed(Duration(seconds: 3));
          ScaffoldFeatureController controller =
              scaffoldMessengerState.showSnackBar(SnackBar(
            content: Text('Test snackbar'),
            behavior: SnackBarBehavior.floating,
          ));
          final result = await controller.closed;
          print(result);
        },
        tooltip: 'Show',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('page 2'),
      ),
    );
  }
}
