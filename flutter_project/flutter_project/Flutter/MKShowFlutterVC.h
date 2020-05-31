//
//  MKShowFlutterVC.h
//  flutter_project
//
//  Created by zhengMK on 2020/4/16.
//  Copyright © 2020 zhengMK. All rights reserved.
//  展示flutter，可以继承与项目中的BaseVC

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKShowFlutterVC : UIViewController

@property (nonatomic, copy) NSString* routeName;


@property (nonatomic, strong) NSString* pageKey;
@property (nonatomic, strong) NSString* pageUrl;

@property (nonatomic, assign) NSInteger tabIndex;

@end

NS_ASSUME_NONNULL_END
