//
//  UIView+StringTag.h
//  AppAustriaX
//
//  Created by 梵天 on 14-7-4.
//  Copyright (c) 2014年 Austria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (StringTag)

@property (nonatomic, strong) NSString *stringTag;
@property (nonatomic, strong) NSString *stringSign;//数量的小标签


- (UIView *)viewWithStringTag:(NSString *)tag;

- (UIView *)findFirstResponder;

//圆角
-(void)bezierPathByRoundingCorners:(UIRectCorner )corner cornerRadii:(CGSize)size;
- (UIViewController*)xViewController;//获取当前控制器
//获取对象所有属性
- (NSDictionary *)properties_apsVC;


@end
