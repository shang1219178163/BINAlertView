//
//  UIImageView+Helper.h
//  ChildViewControllers
//
//  Created by BIN on 2018/1/16.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Helper)

/**
 动画总方法
 */
- (void)startAnimationShowType:(NSString *)type imageArr:(NSArray *)imageArr;

/**
 翻转动画
 */
- (void)startAnimationWithImageArr:(NSArray *)imageArr;

+(UIImageView *)imgViewWithRect:(CGRect)rect imageList:(NSArray *)imageList type:(NSNumber *)type;

- (void)BN_addCorner:(CGFloat)radius;

- (void)loadImage:(id)image type:(NSNumber *)type;

- (void)loadImage:(id)image imageDefault:(NSString *)imageDefault;

@end
