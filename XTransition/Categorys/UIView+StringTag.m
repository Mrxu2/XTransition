//
//  UIView+StringTag.m
//  AppAustriaX
//
//  Created by 梵天 on 14-7-4.
//  Copyright (c) 2014年 Austria. All rights reserved.
//

#import "UIView+StringTag.h"
#import <objc/runtime.h>

#define WEAKSELF_MACRO __weak typeof(self) weakSelf = self;

static char viewStringTag;

@implementation UIView (StringTag)

- (void)setStringTag:(NSString *)stringTag{

    objc_setAssociatedObject(self, &viewStringTag, stringTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)stringTag{
    
    return objc_getAssociatedObject(self, &viewStringTag);
}
/**
 红色标记
 @param stringSign 0:隐藏; >0:展示数字（>99 = 99+）; <0:显示小红点
 */
-(void)setStringSign:(NSString *)stringSign
{
    if ([stringSign integerValue] < 0) {
        NSInteger width = 4;
        NSInteger offset = 5;
        NSInteger top = 0;
        WEAKSELF_MACRO
        UILabel *labSign = (UILabel *)[self viewWithStringSign:stringSign];
        labSign.backgroundColor = [UIColor redColor];
        labSign.text = @"";
        labSign.layer.cornerRadius = width/2;
        [labSign mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).with.offset(top);
            make.right.equalTo(weakSelf).with.offset(offset);
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];
        return;
    }
    
    NSInteger width = self.height < 40?15:20;
    //数量的小标签String
    UILabel *labSign = (UILabel *)[self viewWithStringSign:stringSign];
    labSign.backgroundColor = [UIColor whiteColor];
    if (!labSign) {
        return;
    }
    stringSign = [stringSign integerValue] > 99?@"99+":stringSign;
    if (stringSign.length >= 2) {
        [labSign mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(stringSign.length == 2?width+2:width+12, width));
        }];
    }
    labSign.text = stringSign;
}
-(UILabel *)viewWithStringSign:(NSString *)stringSign
{
    //数量的小标签 Lab
    UILabel *labSign = (UILabel *)[self viewWithStringTag:@"signTag"];
    if ([NSString isNullString:stringSign] || [stringSign integerValue] == 0) {
        if (labSign) {
            labSign.hidden = YES;[labSign removeFromSuperview];labSign = nil;
        }
        return nil;
    }
    if (!labSign) {
        NSInteger width = self.height < 40?15:20;
        NSInteger offset = self.height < 40?-15:-10;
        NSInteger top = self.height < 40?-5:0;

        labSign = [[UILabel alloc]init];
        labSign.text = stringSign;
        labSign.textAlignment = NSTextAlignmentCenter;
        labSign.font = [UIFont systemFontOfSize:12];
        labSign.textColor = [UIColor redColor];
        labSign.layer.masksToBounds = YES;
        labSign.layer.cornerRadius = width/2;
        labSign.stringTag = @"signTag";
        labSign.backgroundColor = [UIColor whiteColor];
        labSign.layer.borderWidth = 1;
        labSign.layer.borderColor = [UIColor redColor].CGColor;
        [self addSubview:labSign];
        WEAKSELF_MACRO
        [labSign mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).with.offset(top);
            make.right.equalTo(weakSelf).with.offset(offset);
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];
    }
    return labSign;
}

//获取对象所有属性
- (NSDictionary *)properties_apsVC
{
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

- (UIView *)viewWithStringTag:(NSString *)tag{
    
    UIView *targetView = nil;
    for (UIView *view in self.subviews) {
        
        if ([view.stringTag isEqualToString:tag]) {
            targetView = view;
            break;
        }else{
            targetView = [view viewWithStringTag:tag];
            if (targetView) {
                break;
            }
        }
    }
    
    return targetView;
}

- (UIView *)findFirstResponder{
    
    UIView *firstResponder = nil;
    if (self.isFirstResponder) {
        firstResponder = self;
    }else{
        
        for (UIView *view in self.subviews) {
            
            if (view.isFirstResponder) {
                firstResponder = view;
                break;
            }else{
                
                firstResponder = [view findFirstResponder];
                if (firstResponder) {
                    break;
                }
            }
        }
    }
    return firstResponder;
}


-(void)bezierPathByRoundingCorners:(UIRectCorner )corner cornerRadii:(CGSize)size
{
//    UIRectCornerBottomLeft|UIRectCornerTopLeft
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:size];
    
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
   
}

- (UIViewController*)xViewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)nextResponder;
            
        }
        
    }
    
    return nil;
    
}
@end
