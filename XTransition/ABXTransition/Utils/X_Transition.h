//
//  X_Transition.h
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface X_Transition : NSObject<UIViewControllerAnimatedTransitioning>


/**
 格式别错了,不想写多余费代码,2维数组,@[@[原图控件name,结果图控件name]];用kvc加载的;
 
 @[@[@"mainImageView",@"mainImageView"]]
 @[@[@"mainImageView",@"mainImageView"],@[@"titleLabel",@"titleLabel"]]
 
 */
+ (instancetype)transitionWithViewArray:(NSArray *)array;

+ (instancetype)transitionWithViewArray:(NSArray *)array Xframe:(CGRect)xframe;


@end
