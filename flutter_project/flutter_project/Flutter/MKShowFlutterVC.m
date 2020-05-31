//
//  MKShowFlutterVC.m
//  flutter_project
//
//  Created by zhengMK on 2020/4/16.
//  Copyright © 2020 zhengMK. All rights reserved.
//

#import "MKShowFlutterVC.h"
#import "MKFlutterViewController.h"
#import "MKFlutterEngineMgr.h"

@interface MKShowFlutterVC ()

@property (nonatomic, strong) MKFlutterViewController* flutterVC;
@property (nonatomic, strong) UINavigationController* navVC;

@end

@implementation MKShowFlutterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FlutterEngine* flutterEngine = [[[MKFlutterEngineMgr sharedInstance] flutterEngines] objectAtIndex:_tabIndex];
    self.flutterVC = [[MKFlutterViewController alloc] initWithEngine:flutterEngine  nibName:nil bundle:nil];
    _flutterVC.routeName = _routeName;
    
    /* 兼容页面抖动 */
     UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.flutterVC];
     navigationController.navigationBarHidden = YES;
     navigationController.view.frame = self.view.bounds;
     [self.view addSubview:navigationController.view];
    self.navVC = navigationController;
}

- (void)dealloc {
    self.navVC = nil;
    self.flutterVC = nil;
}

@end
