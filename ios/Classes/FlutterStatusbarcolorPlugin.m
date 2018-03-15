#import "FlutterStatusbarcolorPlugin.h"

#define ANDROID_COLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0  alpha:((c>>24)&0xFF)/255.0]

@implementation FlutterStatusbarcolorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"plugins.fuyumi.com/statusbar"
            binaryMessenger:[registrar messenger]];
  FlutterStatusbarcolorPlugin* instance = [[FlutterStatusbarcolorPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"setstatusbarcolor" isEqualToString:call.method]) {
    NSNumber *color = call.arguments[@"color"];
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    int colors = @([color intValue]);
    statusBar.backgroundColor = ANDROID_COLOR(colors);
    result(nil);
  } else if ([@"setnavigationbarcolor" isEqualToString:call.method]) {
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
