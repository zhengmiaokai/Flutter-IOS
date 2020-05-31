//
//  MKFlutterViewController.m
//  LeCard
//
//  Created by mikazheng on 2019/12/27.
//  Copyright © 2019 LC. All rights reserved.
//

#import "MKFlutterViewController.h"
#import "MKPluginRegistrant.h"
#import "MKFlutterBridgeHandle.h"

static NSString * const kFlutterRouteChannelName = @"com.base.test/route";

@interface MKFlutterViewController ()

@property (nonatomic, strong) FlutterMethodChannel* routeChannel;

@property (nonatomic, strong) MKFlutterBridgeHandle* flutterBridge;

@end

static FlutterEngine* flutterEngine = nil;

@implementation MKFlutterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (instancetype)initWithEngine:(FlutterEngine*)engine nibName:(nullable NSString*)nibName bundle:(nullable NSBundle*)nibBundle {
    self = [super initWithEngine:engine nibName:nibName bundle:nibBundle];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    
    self.flutterBridge = [[MKFlutterBridgeHandle alloc] initWithContainer:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActiveHandle:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    /* 默认都是StandardCodec，Codec需要保持与flutter端一致 */
    self.routeChannel = [FlutterMethodChannel methodChannelWithName:kFlutterRouteChannelName binaryMessenger:[self binaryMessenger]];
}

- (void)setRouteName:(NSString *)routeName {
    _routeName = [routeName copy];
    [self invokeRoute:@"InitialRoute" arguments:@{@"route":routeName}];
}

- (void)invokeRoute:(NSString*)method arguments:(id _Nullable)arguments {
    [self.routeChannel invokeMethod:method arguments:arguments result:^(id  _Nullable result) {
        
    }];
}

- (void)becomeActiveHandle:(NSNotification *)notification {
    [self.flutterBridge sendMessageName:@"didBecomeActiveNotification" args:nil];
}

- (BOOL)loadDefaultSplashScreenView {
    return NO;
}

- (void)dealloc {
    
}

@end
