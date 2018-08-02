//
//  UIColor+Helper.m
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)


+ (UIColor *)colorWithHexString:(NSString *)colorString
{
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)randomColor{
    
    CGFloat number = 256.0;
    
    CGFloat red = arc4random_uniform(number);
    CGFloat green = arc4random_uniform(number);
    CGFloat blue = arc4random_uniform(number);
    
    return [UIColor colorWithRed:red/number green:green/number blue:blue/number alpha:1];
}


@end
