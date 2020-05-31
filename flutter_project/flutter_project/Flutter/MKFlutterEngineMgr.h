//
//  MKFlutterEngineMgr.h
//  flutter_project
//
//  Created by zhengMK on 2020/4/17.
//  Copyright © 2020 zhengMK. All rights reserved.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKFlutterEngineMgr : NSObject

@property (nonatomic, strong) NSArray* flutterEngines;

+ (instancetype)sharedInstance;

- (void)initEngines;

@end

NS_ASSUME_NONNULL_END
