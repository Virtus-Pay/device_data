#import "DeviceDataPlugin.h"
#if __has_include(<device_data/device_data-Swift.h>)
#import <device_data/device_data-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "device_data-Swift.h"
#endif

@implementation DeviceDataPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDeviceDataPlugin registerWithRegistrar:registrar];
}
@end
