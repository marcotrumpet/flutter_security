#import "FlutterSecurityPlugin.h"
#if __has_include(<flutter_security/flutter_security-Swift.h>)
#import <flutter_security/flutter_security-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_security-Swift.h"
#endif

@implementation FlutterSecurityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSecurityPlugin registerWithRegistrar:registrar];
}
@end
