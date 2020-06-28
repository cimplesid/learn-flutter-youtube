import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'dart:io' show Platform;

const String STA_DEFAULT_SSID = "STA_SSID";
const String STA_DEFAULT_PASSWORD = "STA_PASSWORD";
const NetworkSecurity STA_DEFAULT_SECURITY = NetworkSecurity.WPA;

const String AP_DEFAULT_SSID = "AP_SSID";
const String AP_DEFAULT_PASSWORD = "AP_PASSWORD";

void main() => runApp(FlutterWifiIoT());

class FlutterWifiIoT extends StatefulWidget {
  @override
  _FlutterWifiIoTState createState() => _FlutterWifiIoTState();
}

class _FlutterWifiIoTState extends State<FlutterWifiIoT> {
  @override
  Widget build(BuildContext poContext) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: getWidgets()),
    );
  }

  String _sPreviousAPSSID = "";
  String _sPreviousPreSharedKey = "";
  List<WifiNetwork> _htResultNetwork = [];
  Map<String, bool> _htIsNetworkRegistered = Map();
  bool _isEnabled = false;
  bool _isConnected = false;

  @override
  initState() {
    WiFiForIoTPlugin.isEnabled().then((val) {
      if (val != null) {
        _isEnabled = val;
      }
    });

    WiFiForIoTPlugin.isConnected().then((val) {
      if (val != null) {
        _isConnected = val;
      }
    });
    getWifis();
    super.initState();
  }

  getWifis() async {
    _htResultNetwork = await loadWifiList();
    setState(() {});
    print(_htResultNetwork.length);
  }

  storeAndConnect(String psSSID, String psKey) async {
    await storeAPInfos();
    await WiFiForIoTPlugin.setWiFiAPSSID(psSSID);
    await WiFiForIoTPlugin.setWiFiAPPreSharedKey(psKey);
  }

  storeAPInfos() async {
    String sAPSSID;
    String sPreSharedKey;
    try {
      sAPSSID = await WiFiForIoTPlugin.getWiFiAPSSID();
    } on PlatformException {
      sAPSSID = "";
    }

    try {
      sPreSharedKey = await WiFiForIoTPlugin.getWiFiAPPreSharedKey();
    } on PlatformException {
      sPreSharedKey = "";
    }

    setState(() {
      _sPreviousAPSSID = sAPSSID;
      _sPreviousPreSharedKey = sPreSharedKey;
    });
  }

  Future<List<APClient>> getClientList(
      bool onlyReachables, int reachableTimeout) async {
    List<APClient> htResultClient;
    try {
      htResultClient = await WiFiForIoTPlugin.getClientList(
          onlyReachables, reachableTimeout);
    } on PlatformException {
      htResultClient = List<APClient>();
    }

    return htResultClient;
  }

  Future<List<WifiNetwork>> loadWifiList() async {
    List<WifiNetwork> htResultNetwork;
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      htResultNetwork = List<WifiNetwork>();
    }

    return htResultNetwork;
  }

  isRegisteredWifiNetwork(String ssid) async {
    bool bIsRegistered;
    try {
      bIsRegistered = await WiFiForIoTPlugin.isRegisteredWifiNetwork(ssid);
    } on PlatformException {
      bIsRegistered = false;
    }

    setState(() {
      _htIsNetworkRegistered[ssid] = bIsRegistered;
    });
  }

  Widget getWidgets() {
    WiFiForIoTPlugin.isConnected().then((val) => setState(() {
          _isConnected = val;
        }));

    return SingleChildScrollView(
      child: Column(
        children: getButtonWidgetsForAndroid(),
      ),
    );
  }

  List<Widget> getButtonWidgetsForAndroid() {
    List<Widget> htPrimaryWidgets = List();
    WiFiForIoTPlugin.isEnabled().then((val) => setState(() {
          _isEnabled = val;
        }));
    htPrimaryWidgets.addAll({
      Container(
        color: Colors.blue,
        height: 350,
        child: Center(
          child: Text(
            'Wifi BruteForce Tool',
            style: TextStyle(color: Colors.black54, fontSize: 35),
          ),
        ),
      ),
      Container(
        child: ListTile(
            leading: Text('Wi-Fi'),
            trailing: Switch(
                value: _isEnabled,
                onChanged: (v) {
                  if (_isEnabled) {
                    WiFiForIoTPlugin.setEnabled(false);
                  } else {
                    WiFiForIoTPlugin.setEnabled(true);
                    getWifis();
                  }
                  setState(() {
                    _isEnabled = !_isEnabled;
                  });
                })),
        color: _isEnabled ? Colors.green : Colors.red,
      ),
      SizedBox(height: 10),
      Text(
        'Wi-Fis Found',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            getWifis();
          }),
      getList()
    });
    if (_isEnabled) {
      WiFiForIoTPlugin.isConnected().then((val) {
        if (val != null) {
          setState(() {
            _isConnected = val;
          });
        }
      });
    }

    return htPrimaryWidgets;
  }

  getList() {
    return ListView.builder(
      itemBuilder: (builder, i) {
        var network = _htResultNetwork[i];

        isRegisteredWifiNetwork(network.ssid);
        var isConnctedWifi =
            ((_htIsNetworkRegistered.containsKey(network.ssid) &&
                _htIsNetworkRegistered[network.ssid]));
        if (_htResultNetwork != null && _htResultNetwork.length > 0) {
          return Container(
            color: isConnctedWifi ? Colors.blueAccent : Colors.transparent,
            child: ListTile(
                title: Text(network.ssid),
                trailing: !isConnctedWifi
                    ? OutlineButton(
                        onPressed: () {
                          showDialog(context: context,builder: (context) {
                            return SimpleDialog(title: Text('Attacking...'),children: [
                              // Text(data)
                            ],);
                          },);
                        },
                        child: Text('Attack'),
                      )
                    : SizedBox()),
          );
        } else
          return Center(
            child: Text('No wifi found'),
          );
      },
      itemCount: _htResultNetwork.length,
      shrinkWrap: true,
    );
  }
}

class PopupCommand {
  String command;
  String argument;

  PopupCommand(this.command, this.argument);
}
