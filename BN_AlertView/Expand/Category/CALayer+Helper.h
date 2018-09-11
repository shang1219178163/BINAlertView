//
//  CALayer+Helper.h
//  BN_AlertView
//
//  Created by hsf on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Helper)

- (void)getLayer;

+(CALayer *)createRect:(CGRect)rect image:(id)image;

@end
