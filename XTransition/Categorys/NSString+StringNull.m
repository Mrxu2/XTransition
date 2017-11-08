//
//  NSString+StringNull.m
//  XTransition
//
//  Created by 许宇航 on 2017/11/8.
//  Copyright © 2017年 许宇航. All rights reserved.
//

#import "NSString+StringNull.h"

@implementation NSString (StringNull)

/*
 * 判断指定字符串是否空字符串（都是'\n'、都是' '，这些都算空字符串）
 */
+ (BOOL)isNullString:(NSString *)string;
{
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if (string.length == 0)
    {
        return YES;
    }
    if (string == nil)
    {
        return true;
    }
    for (int i = 0; i < [string length]; ++i)
    {
        if ([string characterAtIndex:i] != '\n' && [string characterAtIndex:i] != ' ' && [string characterAtIndex:i] != '\r' && [string characterAtIndex:i] != '\t' && [string characterAtIndex:i] != '\f'
            //            && [content characterAtIndex:i] != '\u200b'
            )
        {
            return false;
        }
    }
    return true;
}
@end
