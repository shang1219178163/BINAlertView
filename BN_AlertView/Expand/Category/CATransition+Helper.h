//
//  CATransition+Helper.h
//  HuiZhuBang
//
//  Created by hsf on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

CA_EXTERN NSString * const kCATransitionCube;
CA_EXTERN NSString * const kCATransitionSuckEffect;
CA_EXTERN NSString * const kCATransitionOglFlip;
CA_EXTERN NSString * const kCATransitionRippleEffect;
CA_EXTERN NSString * const kCATransitionPageCurl;
CA_EXTERN NSString * const kCATransitionPageUnCurl;
CA_EXTERN NSString * const kCATransitionCameraIrisHollowOpen;
CA_EXTERN NSString * const kCATransitionCameraIrisHollowClose;

@interface CATransition (Helper)

+(void)animationDuration:(CGFloat)duration animations:(void(^)(void))animations completion:(nullable void (^)(void))completion;

+ (CATransition *)animationDuration:(CGFloat)duration functionName:(NSString *)name type:(NSString *)type subType:(id)subTyp;

@end
