//
//  UIView+XBlock.h
//  ICCProjectManager
//
//  Created by 许宇航 on 2017/10/20.
//  Copyright © 2017年 发子. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^X_ViewTappedBlock) (void);
@interface UIView (XBlock)
@property(nonatomic,copy)X_ViewTappedBlock x_ViewTappedBlock;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *label;

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,copy)NSString *text;
@property(nonatomic)NSTextAlignment textAlignment;


/**
 与单击手势绑定的block
 
 @param tappedBlock 单击手势事件回调的block
 */
- (void)X_whenTappedBlock:(void(^)(void))tappedBlock ;
@end
