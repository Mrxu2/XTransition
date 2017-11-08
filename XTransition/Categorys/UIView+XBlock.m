//
//  UIView+XBlock.m
//  ICCProjectManager
//
//  Created by 许宇航 on 2017/10/20.
//  Copyright © 2017年 发子. All rights reserved.
//

#import "UIView+XBlock.h"
#import <objc/runtime.h>

@implementation UIView (XBlock)
//------- 添加属性 -------//
static void *X_viewTappedBlockKey = &X_viewTappedBlockKey;
-(X_ViewTappedBlock)x_viewTappedBlock
{
    return objc_getAssociatedObject(self, &X_viewTappedBlockKey);
}
-(void)setX_viewTappedBlock:(X_ViewTappedBlock)x_viewTappedBlock
{
    objc_setAssociatedObject(self, &X_viewTappedBlockKey, x_viewTappedBlock, OBJC_ASSOCIATION_COPY);
}

/**
 与单击手势绑定的block
 
 @param tappedBlock 单击手势事件回调的block
 */
- (void)X_whenTappedBlock:(void(^)(void))tappedBlock{
    self.x_viewTappedBlock = tappedBlock;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGesture];
}
// 单击view
- (void)viewTapped {
    if (self.x_viewTappedBlock) {
        self.x_viewTappedBlock();
    }
}

/*
 *imageView
 */
-(UIImageView *)imageView
{
    return [self setXImageView];
}
-(void)setImage:(UIImage *)image
{
    UIImageView *imageView = self.imageView;
    imageView.image = image;
    imageView.alpha = image?1:0;
}
-(UIImageView *)setXImageView
{
    UIImageView *imageView =  (UIImageView *)[self viewWithStringTag:@"imageView"];
    if (imageView) {
        return imageView;
    }
    imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.stringTag = @"imageView";
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    return imageView;
}

/*
 *lab
 */
-(UILabel *)label
{
    return [self setXLabel];
}
-(void)setText:(NSString *)text
{
    UILabel *lab = self.label;
    lab.text = text;
    lab.alpha = [NSString isNullString:text]?0:1;
}
-(void)setFont:(UIFont *)font
{
    UILabel *lab = self.label;
    lab.font = font;
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *lab = self.label;
    lab.textAlignment = textAlignment;
}
-(void)setTextColor:(UIColor *)textColor
{
    UILabel *lab = self.label;
    lab.textColor = textColor;
}
-(UILabel *)setXLabel
{
    UILabel *label =  (UILabel *)[self viewWithStringTag:@"label"];
    if (label) {
        return label;
    }
    label = [[UILabel alloc]initWithFrame:self.bounds];
    label.stringTag = @"label";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = RGB(61, 61, 61);
    [self addSubview:label];
    return label;
}

@end
