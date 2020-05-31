//
//  AppDelegate.m
//  flutter_test
//
//  Created by zhengMK on 2019/12/28.
//  Copyright © 2019 zhengMK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MKFlutterEngineMgr.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController* vc = [[ViewController alloc] init];
    
    UINavigationController* naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = naviVC;
    
    [self.window makeKeyAndVisible];
    
    NSLog(@"Flutter_initEngines_begin: ===== %f", [[NSDate date] timeIntervalSince1970]);
    [[MKFlutterEngineMgr sharedInstance] initEngines];
    NSLog(@"Flutter_initEngines_end: ===== %f", [[NSDate date] timeIntervalSince1970]);
    
    return YES;
}

@end
