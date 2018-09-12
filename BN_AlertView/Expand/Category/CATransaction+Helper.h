//
//  CATransaction+Helper.h
//  HuiZhuBang
//
//  Created by hsf on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CATransaction (Helper)

+(void)animationDuration:(CGFloat)duration animations:(void(^)(void))animations completion:(nullable void (^)(void))completion;

@end
