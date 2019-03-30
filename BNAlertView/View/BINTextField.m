//
//  BINTextField.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINTextField.h"

@implementation BINTextField


- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect rect = [super leftViewRectForBounds:bounds];
//    NSLog(@"leftView_%@",NSStringFromCGRect(rect));
    
    rect.origin.x += self.leftViewPadding; //像右边偏
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super rightViewRectForBounds:bounds];
//    NSLog(@"rightView_%@",NSStringFromCGRect(rect));
    rect.origin.x -= self.rightViewPadding; //像左边偏
    
    return rect;
}


//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rect = [super leftViewRectForBounds:bounds];
    CGFloat startX = self.leftViewPadding + CGRectGetWidth(rect) + 5;
    return CGRectInset(bounds, startX, 0);
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super leftViewRectForBounds:bounds];
    CGFloat startX = self.leftViewPadding + CGRectGetWidth(rect) + 5;
//    NSLog(@"startX %.2f",startX);
    
    return CGRectInset(bounds, startX, 0);
}


@end
