#import "KeyloggerPlugin.h"
#if __has_include(<keylogger/keylogger-Swift.h>)
#import <keylogger/keylogger-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "keylogger-Swift.h"
#endif

@implementation KeyloggerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeyloggerPlugin registerWithRegistrar:registrar];
}
@end
