//
//  UIButton+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/12/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIButton+Helper.h"
#import <objc/runtime.h>

#import "NSObject+Helper.h"

@implementation UIButton (Helper)

-(BlockButton)blockButton{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setBlockButton:(BlockButton)blockButton{
    objc_setAssociatedObject(self, @selector(blockButton), blockButton, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void)BIN_addActionHandler:(BlockButton)handler{
    self.blockButton = handler;
    [self addTarget:self action:@selector(BIN_blockActionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)BIN_blockActionTouched:(UIButton *)sender{
    if (self.blockButton) {
        self.blockButton(sender);
    }
}


+(UIButton *)buttonWithSize:(CGSize)size
                    image_N:(id)image_N
                    image_H:(id)image_H
            imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
    
    if ([image_N isKindOfClass:[NSString class]]) image_N = [UIImage imageNamed:image_N];
    if ([image_H isKindOfClass:[NSString class]]) image_H = [UIImage imageNamed:image_H];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image_N) [btn setImage:[image_N imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (image_H) [btn setImage:image_H forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
        
    CGRect btnRect = btn.frame;
    btnRect.size = size;
    btn.frame = btnRect;

    btn.imageEdgeInsets = imageEdgeInsets;
    return btn;
}

+(UIButton *)buttonWithSize:(CGSize)size
                      title:(NSString *)title
                       font:(NSUInteger)font
               titleColor_N:(UIColor *)titleColor_N
               titleColor_H:(UIColor *)titleColor_H
            titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    if (titleColor_N) [btn setTitleColor:titleColor_N forState:UIControlStateNormal];
    if (titleColor_H) [btn setTitleColor:titleColor_H forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    CGRect btnRect = btn.frame;
    btnRect.size = size;
    btn.frame = btnRect;
    
    btn.titleEdgeInsets = titleEdgeInsets;
    btn.exclusiveTouch = YES;

    if (title.length >= 3) {
        CGSize titleSize = [self sizeWithText:title font:@(font) width:kScreen_width];
        
        btn.frame = CGRectMake(0, 0, titleSize.width, size.height);
        btn.titleEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
        
        if (title.length == 4) {
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.titleLabel.minimumScaleFactor = 1;
        }
    }
    return btn;
}

- (void)startCountdown{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSTimeInterval seconds = 60.f;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds]; // 最后期限
    
    dispatch_source_set_event_handler(_timer, ^{
        NSInteger interval = [endTime timeIntervalSinceNow];
        if (interval > 0) { // 更新倒计时
            NSString *timeStr = [NSString stringWithFormat:@"剩余%ld秒", interval];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                [self setTitle:timeStr forState:UIControlStateNormal];
            });
        }
        else { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
}


- (void)handleBackColor:(UIColor *)backColor textColor:(UIColor *)textColor layerColor:(UIColor *)layerColor{

    [self setBackgroundImage:[UIImage imageWithColor:backColor] forState:UIControlStateNormal];
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self getLayerAllCorners:layerColor];

}

@end
