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
  if ([@"getstatusbarcolor" isEqualToString:call.method]) {
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    UIColor *uicolor = statusBar.backgroundColor;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    if (![uicolor getRed:&red green:&green blue:&blue alpha:&alpha]) {
        CGFloat white;
        if ([uicolor getWhite:&white alpha:&alpha]) {
            red = green = blue = white;
        }
    }
    NSNumber *color = @((red * 255) << 16) | ((green * 255) << 8) | (blue * 255) | ((alpha * 255) << 24);
    result(color);
  } else if ([@"setstatusbarcolor" isEqualToString:call.method]) {
    NSNumber *color = call.arguments[@"color"];
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    int colors = [color intValue];
    statusBar.backgroundColor = ANDROID_COLOR(colors);
    result(nil);
  } else if ([@"setstatusbarwhiteforeground" isEqualToString:call.method]) {
    NSNumber *usewhiteforeground = call.arguments[@"whiteForeground"];
    if ([usewhiteforeground boolValue]) {
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    } else {
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    result(nil);
  } else if ([@"getnavigationbarcolor" isEqualToString:call.method]) {
    result(nil);
  } else if ([@"setnavigationbarcolor" isEqualToString:call.method]) {
    result(nil);
  } else if ([@"setnavigationbarwhiteforeground" isEqualToString:call.method]) {
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
