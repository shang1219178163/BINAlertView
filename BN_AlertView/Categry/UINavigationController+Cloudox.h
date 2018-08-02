//
//  UINavigationController+Cloudox.h
//  SmoothNavDemo
//
//  Created by Cloudox on 2017/3/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>
//导航栏透明
@interface UINavigationController (Cloudox) <UINavigationBarDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) NSString *cloudox;

- (void)setNeedsNavigationBackground:(CGFloat)alpha;

@end
