import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import 'no_internet_connection_screen.dart';


class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  ConnectivityWrapper({required this.child});

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _startMonitoringConnectivity();
  }

  @override
  void dispose() {
    _stopMonitoringConnectivity();
    super.dispose();
  }

  Future<void> _startMonitoringConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _isConnected = _isConnectedStatus(connectivityResult);
    setState(() {});

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = _isConnectedStatus(result);
      });
    });
  }

  void _stopMonitoringConnectivity() {
    _connectivitySubscription?.cancel();
  }

  bool _isConnectedStatus(ConnectivityResult connectivityResult) {
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) {
      return widget.child;
    } else {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => no_internet_screen()));
      });
      return Container(); // Placeholder widget while navigating to the "No Internet" screen
    }
  }
}


