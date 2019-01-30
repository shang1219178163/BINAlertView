//
//  BNCircleView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/17.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNCircle.h"

#import "BNGloble.h"
#import "BNCategory.h"

@implementation BNCircle

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2.0;
    }
    return self;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIApplication.rootController showAlertTitle:@"" msg:@"点击圆形视图"];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    return [path containsPoint: point];
}


@end
