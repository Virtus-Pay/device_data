import 'dart:async';

import 'package:flutter/services.dart';

class DeviceData {
  static const MethodChannel _channel = MethodChannel('device_data');

  static Future<double?> get availableMemorySize async {
    final double? version = await _channel.invokeMethod('available_memory_size');
    return version;
  }

  static Future<double?> get totalMemorySize async {
    final double? version = await _channel.invokeMethod('total_memory_size');
    return version;
  }

  static Future<String?> get cpuModel async {
    final String? version = await _channel.invokeMethod('cpu_model');
    return version;
  }

  static Future<int?> get cpuCores async {
    final int? version = await _channel.invokeMethod('cpu_cores');
    return version;
  }
}
