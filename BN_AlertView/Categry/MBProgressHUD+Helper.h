//
//  MBProgressHUD+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "MBProgressHUD.h"

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

- (void)changeHUDtext:(NSString *)text;
- (void)changeHUDtext:(NSString *)text detailText:(NSString *)detailText;
- (void)changeHUDtext:(NSString *)text detailText:(NSString *)detailText duration:(CGFloat)duration;

+ (void)hideHUD:(MBProgressHUD *)hud animated:(BOOL)animated;

/**
 弃用
 */
+ (void)showToastWithTips:(NSString *)tips inView:(UIView *)inView;


/**
 推荐
 */
+ (void)showToastWithTips:(NSString *)tips place:(id)place;

@end
