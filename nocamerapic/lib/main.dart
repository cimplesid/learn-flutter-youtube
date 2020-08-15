import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

var cameras = [];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LockScreen(),
    );
  }
}

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  var pass = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.red.withOpacity(0.2),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            alignment: Alignment.center,
            child: Text(
              'Enter password to open the app',
              style: TextStyle(fontSize: 30, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                onChanged: (v) {
                  setState(() {
                    pass = v;
                  });
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ),
          Center(
              child: RaisedButton(
            onPressed: () async {
              if (controller.value.isInitialized && pass == "pass") {
                final Directory extDir =
                    await getApplicationDocumentsDirectory();
                final String dirPath = '${extDir.path}/Pictures/flutter_test';
                await Directory(dirPath).create(recursive: true);
                var ran = DateTime.now().millisecondsSinceEpoch.toString();
                final String filePath = '$dirPath/$ran.jpg';
                try {
                  await controller.takePicture(filePath);
                } on CameraException catch (e) {
                  print(e);
                  return null;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Home(
                              image: File(filePath),
                            )));
              }
            },
            child: Text('Unlock'),
          ))
        ],
      ),
    );
  }
}
