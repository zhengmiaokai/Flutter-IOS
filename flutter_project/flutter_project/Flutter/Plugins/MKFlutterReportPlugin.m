//
//  MKFlutterReportPlugin.m
//  flutter_project
//
//  Created by mikazheng on 2020/1/12.
//  Copyright © 2020 mikazheng. All rights reserved.
//

#import "MKFlutterReportPlugin.h"

static NSString * const kFlutterReportChannelName = @"com.base.test/report";

@implementation MKFlutterReportPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:kFlutterReportChannelName binaryMessenger:[registrar messenger]];
    MKFlutterReportPlugin *instance = [[MKFlutterReportPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSLog(@"--futter -- call -- method :%@  arguments:%@",call.method,call.arguments);
}

@end
