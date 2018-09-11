//
//  CALayer+Helper.m
//  BN_AlertView
//
//  Created by hsf on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "CALayer+Helper.h"

@implementation CALayer (Helper)

- (void)getLayer{
    NSArray *subviews = self.sublayers;
    if (subviews.count == 0) return;
    for (CALayer *subview in subviews) {
        subview.borderWidth = 0.5;
        subview.borderColor = UIColor.blueColor.CGColor;
        //        subview.borderColor = UIColor.clearColor.CGColor;
        
        [subview getLayer];
        
    }
}



+(CALayer *)createRect:(CGRect)rect image:(id)image{
    
    NSParameterAssert([image isKindOfClass:[NSString class]] || [image isKindOfClass:[UIImage class]]);
    if ([image isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:image];
    }
    
    CALayer *layer = [CALayer layer];
    layer.frame = rect;
    
    layer.contents = (__bridge id _Nullable)(((UIImage *)image).CGImage);
    layer.contentsScale = UIScreen.mainScreen.scale;
    layer.rasterizationScale = YES;
    return layer;
}

@end
