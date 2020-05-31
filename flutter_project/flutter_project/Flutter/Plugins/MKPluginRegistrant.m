//
//  MKPluginRegistrant.m
//  flutter_project
//
//  Created by mikazheng on 2020/4/7.
//  Copyright © 2020 mikazheng. All rights reserved.
//

#import "MKPluginRegistrant.h"
#import "MKFlutterReportPlugin.h"

@implementation MKPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry> *)registry {
    [super registerWithRegistry:registry];
    
    [MKFlutterReportPlugin registerWithRegistrar:[registry registrarForPlugin:@"LCFlutterReportPlugin"]];
}

@end
