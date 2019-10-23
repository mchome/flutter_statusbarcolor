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

static NSInteger statusBarViewTag = 38482458385;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getstatusbarcolor" isEqualToString:call.method]) {
    UIColor *uicolor;
    UIView * statusBar = [self getStatusBarView];
    uicolor = statusBar.backgroundColor;
    if(uicolor == nil) {
       // since it's nil default to transparent
       uicolor = UIColor.clearColor;
    }

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
    NSNumber *color = @(((int)(red * 255.0) << 16) | ((int)(green * 255.0) << 8) | (int)(blue * 255.0) | ((int)(alpha * 255.0) << 24));
    result(color);
  } else if ([@"setstatusbarcolor" isEqualToString:call.method]) {
    NSNumber *color = call.arguments[@"color"];
    UIView * statusBar = [self getStatusBarView];
    int colors = [color intValue];
    statusBar.backgroundColor = ANDROID_COLOR(colors);
    result(nil);
  } else if ([@"setstatusbarwhiteforeground" isEqualToString:call.method]) {
    NSNumber *usewhiteforeground = call.arguments[@"whiteForeground"];
    if ([usewhiteforeground boolValue]) {
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    } else {
        if (@available(iOS 13, *)) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
        }else{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }
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

- (UIView*) getStatusBarView {
   if (@available(iOS 13, *)) {
       if([UIApplication sharedApplication].keyWindow != nil &&
           [[UIApplication sharedApplication].keyWindow viewWithTag:statusBarViewTag] != nil) {
           return [[UIApplication sharedApplication].keyWindow viewWithTag:statusBarViewTag];
       }
       else {
           UIView* statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame];
           statusBar.tag = statusBarViewTag;
           [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
           return statusBar;
       }
   }
   else {
       return [[UIApplication sharedApplication] valueForKey:@"statusBar"];
   }
    
}

@end
