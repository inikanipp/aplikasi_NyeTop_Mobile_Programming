import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionProvider with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  ConnectionProvider() {
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((result) {
      _updateStatus(result);
    });
  }

  void _updateStatus(ConnectivityResult result) {
    final wasConnected = _isConnected;
    _isConnected = (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
    if (_isConnected != wasConnected) notifyListeners();
  }

  Future<void> _checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    _updateStatus(result);
  }
}
