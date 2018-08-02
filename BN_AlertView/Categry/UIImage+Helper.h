//
//  UIImage+Helper.h
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageRotatedByDegrees:(CGFloat)degrees image:(UIImage *)image;

@end
