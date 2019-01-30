//
//  BNCricleProgressView.m
//  HuiZhuBang
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNCricleProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define RGBA(r, g, b, a)   [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]
#define RGB(r, g, b)        RGBA(r, g, b, 1.0)

@interface BNCricleProgressView()

@property (nonatomic, strong) CAShapeLayer *arcLayer;

@end

@implementation BNCricleProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        
        [self addSubview:self.label];

    }
    return self;
    
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat lineWidth = 2.5;
    CGFloat viewWidth = CGRectGetWidth(rect);
    CGFloat Radius = viewWidth/2.0 - lineWidth;
    CGPoint center = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
    
    CGContextRef progressContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(progressContext, lineWidth);
    CGContextSetRGBStrokeColor(progressContext, 209.0/255.0, 209.0/255.0, 209.0/255.0, 1);
    //绘制环形进度条底框
    CGContextAddArc(progressContext, center.x, center.y, Radius, 0, M_PI*2, 0);
    CGContextDrawPath(progressContext, kCGPathStroke);
    
    //    //绘制环形进度环
    CGFloat to = -M_PI*0.5 + self.progress * M_PI*2; // - M_PI * 0.5为改变初始位置
    
    // 进度数字字号,可自己根据自己需要，从视图大小去适配字体字号
    NSInteger fontNum = viewWidth/4;
    NSInteger width = viewWidth - lineWidth*2;
    
    UIColor * strokeColor = self.progress < 0.1 ? UIColor.redColor : UIColor.greenColor;

    //
    self.label.frame = CGRectMake(0, 0, width, fontNum);
    self.label.center = center;
//    self.label.text = @"0%";
    self.label.text = [self.label.text floatValue] >= 0.0 ? self.label.text : [NSString stringWithFormat:@"%.2f%%",self.progress*100];
    self.label.textColor = strokeColor;
    self.label.font = [UIFont boldSystemFontOfSize:fontNum];
//    [self addSubview:self.label];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:Radius startAngle:-M_PI*0.5 endAngle:to clockwise:YES];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;//46,169,230
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.strokeColor = strokeColor.CGColor;
    layer.lineWidth = lineWidth;
    layer.lineCap = @"round";
    layer.backgroundColor = UIColor.blueColor.CGColor;
    self.arcLayer = layer;
    [self.layer addSublayer:self.arcLayer];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self drawLineAnimation:self.arcLayer];
    });
    
    if (self.progress > 1) {
//        DDLog(@"传入数值范围为 0-1");
        self.progress = 1;
    } else if (self.progress < 0){
//        DDLog(@"传入数值范围为 0-1");
        self.progress = 0;
        return;
    }
}

//定义动画过程
-(void)drawLineAnimation:(CALayer *)layer{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.5;//动画时间
    animation.fromValue = @(0);
    animation.toValue = @(1);
    //    animation.delegate = self;
    [layer addAnimation:animation forKey:@"key"];
}

#pragma mark - -layz
-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = RGB(51, 51, 51);
            
            label;
        });
    }
    return _label;
}

@end
