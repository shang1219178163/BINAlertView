
//
//  UIView+Animation.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UIView+Animation.h"

#import <objc/runtime.h>

@implementation UIView (Animation)

- (void)BN_aimationBigValues:(NSArray *)values{
    
    values = values ? : @[@1.6,];
    
    NSTimeInterval duration = 1.0/(values.count + 1);
   __block NSTimeInterval start;
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        for (NSInteger i = 0; i < values.count; i++) {
            CGFloat scale = [values[i] floatValue];
            
            start = i > 0 ? start + duration : 0;
            [UIView addKeyframeWithRelativeStartTime:start relativeDuration:duration animations:^{
                self.transform = CGAffineTransformMakeScale(scale, scale);
                
            }];
        }

        [UIView addKeyframeWithRelativeStartTime:start relativeDuration:duration animations:^{
            self.transform = CGAffineTransformIdentity;
            
        }];
        
    } completion:nil];
    
}

- (void)BN_aimationBigShapeWithColor:(UIColor *)color{
    UIColor *stroke = color ? : [UIColor redColor];
    UIView * view = self;
    CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderAnimation.fromValue = (id)[UIColor clearColor].CGColor;
    borderAnimation.toValue = (id)[UIColor redColor].CGColor;
    borderAnimation.duration = 0.5f;
    [view.layer addAnimation:borderAnimation forKey:nil];
    
    
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(view.bounds), -CGRectGetMidY(view.bounds), view.bounds.size.width, view.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:view.layer.cornerRadius];
    
    // accounts for left/right offset and contentOffset of scroll view
    CGPoint shapePosition = [view.superview.superview convertPoint:view.center fromView:view.superview];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = stroke.CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = stroke.CGColor;
    circleShape.lineWidth = 2;
    
    [view.superview.superview.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:animation forKey:nil];
    
    
}

@end
