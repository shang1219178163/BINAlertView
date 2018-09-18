//
//  CATransition+Helper.h
//  HuiZhuBang
//
//  Created by hsf on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

//CA_EXTERN NSString * const kCATransitionCube;
//CA_EXTERN NSString * const kCATransitionSuckEffect;
//CA_EXTERN NSString * const kCATransitionOglFlip;
//CA_EXTERN NSString * const kCATransitionRippleEffect;
//CA_EXTERN NSString * const kCATransitionPageCurl;
//CA_EXTERN NSString * const kCATransitionPageUnCurl;
//CA_EXTERN NSString * const kCATransitionCameraIrisHollowOpen;
//CA_EXTERN NSString * const kCATransitionCameraIrisHollowClose;


static NSString * const kCATransitionCube = @"cube";
static NSString * const kCATransitionSuckEffect = @"suckEffect";
static NSString * const kCATransitionOglFlip = @"oglFlip";
static NSString * const kCATransitionRippleEffect = @"rippleEffect";
static NSString * const kCATransitionPageCurl = @"pageCurl";
static NSString * const kCATransitionPageUnCurl = @"pageUnCurl";
static NSString * const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
static NSString * const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";


@interface CATransition (Helper)

+(void)animationDuration:(CGFloat)duration animations:(void(^)(void))animations completion:(nullable void (^)(void))completion;

+ (CATransition *)animationDuration:(CGFloat)duration functionName:(NSString *)name type:(NSString *)type subType:(id)subTyp;

@end
