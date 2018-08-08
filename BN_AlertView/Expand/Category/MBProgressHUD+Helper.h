//
//  MBProgressHUD+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "MBProgressHUD.h"

#import "PopoverView.h"

typedef void(^BlockCompletion)(BOOL isFinished);

@interface MBProgressHUD (Helper)

@property (nonatomic, copy) BlockCompletion blockCompletion;

/**
 (弃用)
 */
+ (MBProgressHUD *)showHUDAddedToView:(UIView *)view animated:(BOOL)animated;

/**
 推荐

 */
+ (void)showHUDinView:(UIView *)inView animated:(BOOL)animated;

+ (void)hideHUD:(MBProgressHUD *)hud animated:(BOOL)animated;

/**
 推荐
 */
+ (void)showToastWithTips:(NSString *)tips place:(id)place;

+ (void)showToastWithTips:(NSString *)tips place:(id)place completion:(void(^)(BOOL didTap))completion;

+ (void)showToastWithTips:(NSString *)tips success:(NSNumber *)success place:(id)place completion:(void(^)(BOOL didTap))completion;

+ (void)showToastWithTips:(NSString *)tips image:(id)image place:(id)place completion:(void(^)(BOOL didTap))completion;

+ (void)showPopByView:(UIView *)pointView items:(NSArray<NSDictionary *> *)items handler:(BlockPopoverView)handler;

@end
