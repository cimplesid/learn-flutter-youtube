import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getPermission();
    SystemAlertWindow.registerOnClickListener(callBack);
  }

  getPermission() async {
    await SystemAlertWindow.checkPermissions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {
                SystemAlertWindow.showSystemWindow(
                  margin: SystemWindowMargin(left: 50),
                  gravity: SystemWindowGravity.TOP,
                  header: SystemWindowHeader(
                    padding: SystemWindowPadding(left: 20),
                    decoration: SystemWindowDecoration(
                        startColor: Colors.red, endColor: Colors.blueGrey),
                    title: SystemWindowText(
                        text: "Hi  this is header", textColor: Colors.white),
                    subTitle: SystemWindowText(
                        text: "Hi  this is header subtitle",
                        textColor: Colors.white),
                  ),
                  body: SystemWindowBody(
                      decoration: SystemWindowDecoration(
                          startColor: Colors.red, endColor: Colors.blueGrey),
                      padding: SystemWindowPadding(left: 20),
                      rows: [
                        EachRow(columns: [
                          EachColumn(
                            text: SystemWindowText(
                                text: "Hi  this is body",
                                textColor: Colors.white),
                          )
                        ])
                      ]),
                  footer: SystemWindowFooter(
                    buttons: [
                      SystemWindowButton(
                          text: SystemWindowText(text: 'close'), tag: "close")
                    ],
                    decoration: SystemWindowDecoration(
                      startColor: Colors.blue,
                    ),
                  ),
                  height: 100,
                );
              },
              color: Colors.green,
              child: Text('Show dialog over other apps'),
            ),
          ),
          Center(
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {
                SystemAlertWindow.closeSystemWindow();
              },
              color: Colors.red,
              child: Text('close dialog'),
            ),
          )
        ],
      ),
    );
  }
}

void callBack(tag) {
  print(tag);
  if (tag == "close") {
    SystemAlertWindow.closeSystemWindow();
  }
}
