import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:device_data/device_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _availableMemorySize = 0;
  double _totalMemorySize = 0;
  String _cpuModel = '';
  int _cpuCores = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    double availableMemorySize;
    double totalMemorySize;
    String cpuModel;
    int cpuCores;

    try {
      availableMemorySize = await DeviceData.availableMemorySize ?? 0;
    } on PlatformException {
      availableMemorySize = 0;
    }

    try {
      totalMemorySize = await DeviceData.totalMemorySize ?? 0;
    } on PlatformException {
      totalMemorySize = 0;
    }

    try {
      cpuModel = await DeviceData.cpuModel ?? "";
    } on PlatformException {
      cpuModel = "";
    }

    try {
      cpuCores = await DeviceData.cpuCores ?? 0;
    } on PlatformException {
      cpuCores = 0;
    }

    if (!mounted) return;

    setState(() {
      _availableMemorySize = availableMemorySize;
      _totalMemorySize = totalMemorySize;
      _cpuModel = cpuModel;
      _cpuCores = cpuCores;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device Data'),
        ),
        body: SingleChildScrollView(
            child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Available memory size: $_availableMemorySize'),
              Text('Total memory size: $_totalMemorySize'),
              Text('CPU model: $_cpuModel'),
              Text('CPU cores: $_cpuCores'),
            ],
          ),
        )),
      ),
    );
  }
}
