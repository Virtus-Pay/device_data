import Flutter
import UIKit

extension UIDevice {
  var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    if let value = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
      return value
    } else {
      return identifier
    }
  }
}

public class SwiftDeviceDataPlugin: NSObject, FlutterPlugin {
  static let BRIDGE_NAME = "device_data"
  static var methodCall: String!
  static var result: FlutterResult!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: BRIDGE_NAME, binaryMessenger: registrar.messenger())
    let instance = SwiftDeviceDataPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if #available(iOS 14, *) {
      SwiftDeviceDataPlugin.result = result
      SwiftDeviceDataPlugin.methodCall = call.method
      
      self.selectMethod()
    } else {
      SwiftDeviceDataPlugin.result(FlutterMethodNotImplemented)
    }
  }

  private func selectMethod() {
      switch SwiftDeviceDataPlugin.methodCall {
  
          case "available_memory_size": self.availableMemorySize()
          case "total_memory_size": self.totalMemorySize()
          case "cpu_model": self.cpuModel()
          case "cpu_cores": self.cpuCores()
          
          default: SwiftDeviceDataPlugin.result(FlutterMethodNotImplemented)
      }
  }

  private func availableMemorySize() {
    SwiftDeviceDataPlugin.result(nil)
  }

  private func totalMemorySize() {
    SwiftDeviceDataPlugin.result(Double(ProcessInfo.processInfo.physicalMemory)/(1024*1024*1024))
  }

  private func cpuModel() {
    SwiftDeviceDataPlugin.result(UIDevice.current.modelName)
  }

  private func cpuCores() {
    SwiftDeviceDataPlugin.result(ProcessInfo.processInfo.processorCount)
  }
}
