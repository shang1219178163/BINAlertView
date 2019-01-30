//
//  BNTextField.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BNTextField.h"

@interface BNTextField()

@end

@implementation BNTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x += self.leftViewPadding; //像右边偏
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super rightViewRectForBounds:bounds];
    rect.origin.x -= self.rightViewPadding; //像左边偏
    
    return rect;
}

// Placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rect = [super textRectForBounds:bounds];
    
    CGFloat top = 0;
    CGFloat left = 3;
    CGFloat bottom = 0;
    CGFloat right = 3;
    if (self.leftViewPadding > 0) {
        left += self.leftViewPadding;
        
    }
    
    if (self.rightViewPadding > 0) {
        right += self.rightViewPadding;
        
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return UIEdgeInsetsInsetRect(rect, insets);
}

// Text position
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rect = [super editingRectForBounds:bounds];

    CGFloat top = 0;
    CGFloat left = 3;
    CGFloat bottom = 0;
    CGFloat right = 3;
    if (self.leftViewPadding > 0) {
        left += self.leftViewPadding;
        
    }
    
    if (self.rightViewPadding > 0) {
        right += self.rightViewPadding;
        
    }

    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return UIEdgeInsetsInsetRect(rect, insets);
}

// Clear button
- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    
    CGFloat top = 0;
    CGFloat left = 0;
    CGFloat bottom = 0;
    CGFloat right = 0;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return UIEdgeInsetsInsetRect(rect, insets);

}

- (void)textFieldDeleteBackward{
    [super deleteBackward];
    
    if (self.keyInputDelegate && [self.keyInputDelegate respondsToSelector:@selector(deleteBackward)]) {
        [self.keyInputDelegate textFieldDeleteBackward];
    }

}

@end
