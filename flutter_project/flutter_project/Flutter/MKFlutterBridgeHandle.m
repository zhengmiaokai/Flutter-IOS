//
//  MKFlutterBridgeHandle.m
//  flutter_project
//
//  Created by zhengMK on 2020/5/10.
//  Copyright © 2020 zhengMK. All rights reserved.
//

#import "MKFlutterBridgeHandle.h"

static NSString * const kFlutterMethodChannelName = @"com.base.test/bridge";

static NSString * const kFlutterMessagehannelName = @"com.base.test/message";

@interface MKFlutterBridgeHandle ()

@property (nonatomic, weak) FlutterViewController* container;

@property (nonatomic, strong) FlutterMethodChannel* methodChannel;

@property (nonatomic, strong) FlutterBasicMessageChannel* baseMessageChannel;

@end

@implementation MKFlutterBridgeHandle

- (instancetype)initWithContainer:(FlutterViewController *)container {
    self = [super init];
    if (self) {
        self.container = container;
        [self initChannels];
    }
    return self;
}

- (void)initChannels {
    /* 默认都是StandardCodec，Codec需要保持与flutter端一致 */
    self.baseMessageChannel = [FlutterBasicMessageChannel messageChannelWithName:kFlutterMessagehannelName binaryMessenger:[self.container binaryMessenger]];
    
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:kFlutterMethodChannelName binaryMessenger:[self.container binaryMessenger]];
    
    /* flutter调用native方法 */
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if(!call.arguments && !call.method) {
            result(FlutterMethodNotImplemented);
            return;
        }
        NSString *method = (NSString *)call.method;
        NSDictionary *arguments = (NSDictionary *)call.arguments;
        NSLog(@"method:%@; arguments:%@", method, arguments);
        result(@"{\"key\":\"value\"}");
    }];
}

/* native调用flutter方法 */
- (void)invokeFlutterMethod:(NSString *)method arguments:(NSString *)arguments result:(FlutterResult )callback {
    [self.methodChannel invokeMethod:method arguments:arguments result:callback];
}

/* 广播 */
- (void)sendMessageName:(NSString *)messageName args:(id _Nullable)arguments {
    [self.baseMessageChannel sendMessage:@{@"messageName": messageName, @"arguments": arguments?arguments:@""}];
}

@end
