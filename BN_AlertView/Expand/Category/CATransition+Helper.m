
//
//  CATransition+Helper.m
//  HuiZhuBang
//
//  Created by hsf on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "CATransition+Helper.h"

//NSString * const kCATransitionCube = @"cube";
//NSString * const kCATransitionSuckEffect = @"suckEffect";
//NSString * const kCATransitionOglFlip = @"oglFlip";
//NSString * const kCATransitionRippleEffect = @"rippleEffect";
//NSString * const kCATransitionPageCurl = @"pageCurl";
//NSString * const kCATransitionPageUnCurl = @"pageUnCurl";
//NSString * const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
//NSString * const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";

@implementation CATransition (Helper)


+ (CATransition *)animationDuration:(CGFloat)duration functionName:(NSString *)name type:(NSString *)type subType:(id)subType {
    
    NSArray * array = @[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight,];
    NSAssert([subType isKindOfClass:[NSString class]] && [array containsObject:subType] || [subType isKindOfClass:[NSNumber class]] && array.count > [subType integerValue], @"动画方向错误!");
    
    if ([subType isKindOfClass:[NSNumber class]] && array.count > [subType integerValue]) {
        subType = array[[subType integerValue]];
        
    }
    
    NSArray * functions = @[kCAMediaTimingFunctionLinear,
                            kCAMediaTimingFunctionEaseIn,
                            kCAMediaTimingFunctionEaseOut,
                            kCAMediaTimingFunctionEaseInEaseOut,
                            kCAMediaTimingFunctionDefault,];
    NSString * function = name && [functions containsObject:name] ? name : kCAMediaTimingFunctionDefault;
    
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:function];
    
    animation.type = type;//过渡效果
    animation.subtype = subType;//过渡方向
    //    [self.view.layer addAnimation:animation forKey:nil];
    return animation;
}

//+ (CATransition *)animationType:(NSString *)type subType:(id)subType{
//
//    NSArray * array = @[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight,];
//    NSAssert([subType isKindOfClass:[NSString class]] && [array containsObject:subType] || [subType isKindOfClass:[NSNumber class]] && array.count > [subType integerValue], @"动画方向错误!");
//
//    if ([subType isKindOfClass:[NSNumber class]] && array.count > [subType integerValue]) {
//        subType = array[[subType integerValue]];
//
//    }
//
//    CATransitionCATransition *animation = [CATransition animation];
//    //动画时间
//    animation.duration = 1.0f;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
//    animation.type = type;//过渡效果
//    animation.subtype = subType;//过渡方向
//    //    [self.view.layer addAnimation:animation forKey:nil];
//    return animation;
//}

@end
