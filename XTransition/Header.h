//
//  Header.h
//  XTransition
//
//  Created by 许宇航 on 2017/11/8.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "UIView+Extension.h"
#import "Masonry.h"
#import "NSString+StringNull.h"
#import "UIView+StringTag.h"

#define WEAKSELF_MACRO __weak typeof(self) weakSelf = self;
#define mainBounds     [[UIScreen mainScreen] bounds]
#define mainHeight     [[UIScreen mainScreen] bounds].size.height
#define mainWidth      [[UIScreen mainScreen] bounds].size.width
#define mainStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define mainNavBarHeight   44
#define mainNavHeight (mainNavBarHeight +mainStatusBarHeight)
#define mainTabBarSurplusHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?20:0)
#define MyViewHeight(height)                height / 375.0 * KScreen_Width
#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]


#endif /* Header_h */
