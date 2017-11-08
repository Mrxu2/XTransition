//
//  ViewController.h
//  XTransition
//
//  Created by 许宇航 on 2017/11/6.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBaseViewController.h"
@interface B_ViewController :XBaseViewController<UINavigationControllerDelegate>
@property(nonatomic,retain)UIView *ACell;
@property(nonatomic,strong)UIColor *color;

@end

