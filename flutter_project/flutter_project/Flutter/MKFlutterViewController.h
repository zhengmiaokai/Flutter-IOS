//
//  MKFlutterViewController.h
//  LeCard
//
//  Created by mikazheng on 2019/12/27.
//  Copyright © 2019 LC. All rights reserved.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * vc对象被engine强引用，页面退出时不用调用dealloc；
 * 只有创建新的vc对象（engine强引用指向新的vc对象），原本的vc对象才会被释放。
 */
@interface MKFlutterViewController : FlutterViewController

@property (nonatomic, copy) NSString* routeName;

@end

NS_ASSUME_NONNULL_END
