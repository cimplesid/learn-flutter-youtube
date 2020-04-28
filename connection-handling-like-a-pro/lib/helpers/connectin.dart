import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Connection extends ChangeNotifier {
  bool _hasConnection = false;
  get hasConnection => _hasConnection;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    _updateConnectionStatus(result);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _hasConnection = true;
        break;

      case ConnectivityResult.mobile:
        _hasConnection = true;
        break;

      case ConnectivityResult.none:
        _hasConnection = false;
        break;
    }
    notifyListeners();
  }

  cancel() {
    _connectivitySubscription?.cancel();
  }
}
