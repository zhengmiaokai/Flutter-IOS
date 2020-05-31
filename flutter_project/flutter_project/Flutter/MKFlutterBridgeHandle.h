//
//  MKFlutterBridgeHandle.h
//  flutter_project
//
//  Created by zhengMK on 2020/5/10.
//  Copyright © 2020 zhengMK. All rights reserved.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKFlutterBridgeHandle : NSObject

- (instancetype)initWithContainer:(FlutterViewController *)container;

/* 调用flutter方法 */
- (void)invokeFlutterMethod:(NSString *)method arguments:(NSString *)arguments result:(FlutterResult )callback;

/* 广播 */
- (void)sendMessageName:(NSString *)messageName args:(id _Nullable)arguments;

@end

NS_ASSUME_NONNULL_END
