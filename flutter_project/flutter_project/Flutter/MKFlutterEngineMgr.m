//
//  MKFlutterEngineMgr.m
//  flutter_project
//
//  Created by zhengMK on 2020/4/17.
//  Copyright © 2020 zhengMK. All rights reserved.
//

#import "MKFlutterEngineMgr.h"
#import "MKPluginRegistrant.h"

@implementation MKFlutterEngineMgr

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MKFlutterEngineMgr* mgr;
    dispatch_once(&onceToken, ^{
        mgr = [[self alloc] init];
    });
    return mgr;
}

- (void)initEngines {
    // 多个tab页多个引擎，二级页复用单引擎
    NSMutableArray* mArr = [NSMutableArray arrayWithCapacity:2];
    for (int i=0; i<2; i++) {
        FlutterEngine* engine = [[FlutterEngine alloc] initWithName:@"ios_flutter" project:nil];
        [engine runWithEntrypoint:nil];
        [MKPluginRegistrant registerWithRegistry:engine];
        [mArr addObject:engine];
    }
    self.flutterEngines = mArr;
}

@end
