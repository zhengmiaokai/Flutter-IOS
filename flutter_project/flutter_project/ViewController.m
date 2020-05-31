//
//  ViewController.m
//  flutter_test
//
//  Created by zhengMK on 2019/12/28.
//  Copyright © 2019 zhengMK. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MKShowFlutterVC.h"

@interface ViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) FlutterMethodChannel *methodChannel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    [self.navigationController setNavigationBarHidden:YES];
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"flutter页面-home & myAPP" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 160, self.view.bounds.size.width, 60);
    [button addTarget:self action:@selector(jumpToFlutterHomeAndMyApp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"flutter页面-home" forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 320, self.view.bounds.size.width, 60);
    [button1 addTarget:self action:@selector(jumpToFlutterHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"flutter页面-myAPP" forState:UIControlStateNormal];
    button2.frame = CGRectMake(0, 480, self.view.bounds.size.width, 60);
    [button2 addTarget:self action:@selector(jumpToFlutterMyApp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)jumpToFlutterHomeAndMyApp:(id)sender {
    
    MKShowFlutterVC* vc0 = [[MKShowFlutterVC alloc] init];
    vc0.tabIndex = 0;
    [vc0 setRouteName:@"/home"];
    [vc0 setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1]];

    MKShowFlutterVC* vc1 = [[MKShowFlutterVC alloc] init];
    vc0.tabIndex = 1;
    [vc1 setRouteName:@"/myApp"];
    [vc1 setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1]];
    
    UITabBarController* rootVC = [[UITabBarController alloc] init];
    rootVC.delegate = self;
    rootVC.viewControllers = @[vc0, vc1];

    [self.navigationController pushViewController:rootVC animated:YES];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)jumpToFlutterHome:(id)sender {
    MKShowFlutterVC* vc = [[MKShowFlutterVC alloc] init];
    [vc setRouteName:@"/home"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpToFlutterMyApp:(id)sender {
    MKShowFlutterVC* vc = [[MKShowFlutterVC alloc] init];
    [vc setRouteName:@"/myApp"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
