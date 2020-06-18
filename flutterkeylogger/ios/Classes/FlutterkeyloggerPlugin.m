#import "FlutterkeyloggerPlugin.h"
#if __has_include(<flutterkeylogger/flutterkeylogger-Swift.h>)
#import <flutterkeylogger/flutterkeylogger-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterkeylogger-Swift.h"
#endif

@implementation FlutterkeyloggerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterkeyloggerPlugin registerWithRegistrar:registrar];
}
@end
