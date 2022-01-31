import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_data/device_data.dart';

void main() {
  const MethodChannel channel = MethodChannel('device_data');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case "available_memory_size":
          return 0.00;
        case "total_memory_size":
          return 0.00;
        case "cpu_model":
          return "";
        case "cpu_cores":
          return 0;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getAvailableMemorySize', () async {
    expect(await DeviceData.availableMemorySize, 0.00);
  });
  test('getTotalMemorySize', () async {
    expect(await DeviceData.totalMemorySize, 0.00);
  });
  test('getCpuModel', () async {
    expect(await DeviceData.cpuModel, "");
  });
  test('getCpuCores', () async {
    expect(await DeviceData.cpuCores, 0);
  });
}
