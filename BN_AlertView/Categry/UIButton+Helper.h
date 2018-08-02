//
//  UIButton+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/12/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NSObject+Helper.h"//优点全部子类使用;使用性能较差需要一级级去查找

typedef void(^BlockButton)(id objc);

@interface UIButton (Helper)

@property (nonatomic, copy) BlockButton blockButton;//其他类使用该属性注意性能

- (void)BIN_addActionHandler:(BlockButton)handler;

/**
 导航栏按钮
 */
+(UIButton *)buttonWithSize:(CGSize)size
                 image_N:(id)image_N
                 image_H:(id)image_H
         imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 导航栏按钮
 */
+(UIButton *)buttonWithSize:(CGSize)size
                   title:(NSString *)title
                    font:(NSUInteger)font
            titleColor_N:(UIColor *)titleColor_N
            titleColor_H:(UIColor *)titleColor_H
         titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;

/**
 验证码倒计时默认60s
 */
- (void)startCountdown;

- (void)handleBackColor:(UIColor *)backColor textColor:(UIColor *)textColor layerColor:(UIColor *)layerColor;

@end
