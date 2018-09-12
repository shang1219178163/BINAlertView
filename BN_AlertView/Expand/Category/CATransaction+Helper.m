//
//  CATransaction+Helper.m
//  HuiZhuBang
//
//  Created by hsf on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "CATransaction+Helper.h"

@implementation CATransaction (Helper)

+(void)animationDuration:(CGFloat)duration animations:(void(^)(void))animations completion:(nullable void (^)(void))completion{
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    animations();
    [CATransaction setCompletionBlock:completion];
    [CATransaction commit];
    
}


@end
