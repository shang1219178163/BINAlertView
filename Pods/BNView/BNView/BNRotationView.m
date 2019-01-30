//
//  BNRotationView.m
//  BNAnimation
//
//  Created by BIN on 2018/9/21.
//  Copyright © 2018年 whkj. All rights reserved.
//

#import "BNRotationView.h"

#import "BNGloble.h"
#import "BNCategory.h"

//static CGFloat kPadding = 8.0;

@interface BNRotationView()

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) CAShapeLayer *layerFront;
@property (nonatomic, strong) CAShapeLayer *layerBack;
@property (nonatomic, strong) CABasicAnimation * animation;

@end

@implementation BNRotationView

-(void)dealloc{
    [self.imgView removeObserver:self forKeyPath:@"image"];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isColorFollow = YES;
        
        self.imgView.frame = CGRectMake(kPadding, kPadding, CGRectGetWidth(frame) - kPadding*2, CGRectGetHeight(frame) - kPadding*2);
        [self addSubview:self.imgView];

        CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){{0, 0}, frame.size}].CGPath; //设置绘制路径
        _layerFront = [CAShapeLayer layerRect:frame path:path strokeEnd:0.5 fillColor:UIColor.clearColor strokeColor:UIColor.redColor lineWidth:1];
        _layerFront.position = self.center;
//        self.layerFront.anchorPoint = CGPointMake(0.5, 0.5);//锚点设置为图片中心，绕中心抖动
        //以subLayer的形式添加给self.view
        [self.layer addSublayer:_layerFront];
        
        
        UIColor * colorBack = [UIColor colorWithWhite:0.8 alpha:0.5];
        _layerBack = [CAShapeLayer layerRect:frame path:path strokeEnd:1 fillColor:UIColor.clearColor strokeColor:colorBack lineWidth:2];
        _layerBack.position = self.center;
        [self.layer insertSublayer:_layerBack below:_layerFront];
        
        //    self.layer.anchorPoint = CGPointMake(0.5, 0.5);//锚点设置为图片中心，绕中心抖动
        [_layerFront addAnimation:self.animation forKey:@"rotationAnim"];
        
        //监听
        [self.imgView addObserver:self forKeyPath:@"image" options:0 context:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(kPadding, kPadding, CGRectGetWidth(self.frame) - kPadding*2, CGRectGetHeight(self.frame) - kPadding*2);

    CGRect bounds = (CGRect){{0, 0}, self.frame.size};
    self.layerFront.frame = self.layerBack.frame = bounds;

    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:bounds].CGPath; //设置绘制路径
    self.layerFront.path = self.layerBack.path = path;
    

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"image"]) {
        self.layerFront.strokeColor = self.isColorFollow  ? self.imgView.image.mostColor.CGColor : UIColor.greenColor.CGColor;
        
    }
    
}

#pragma mark - -layz

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectZero];
            view.image = [UIImage imageNamed:@"Twitter"];

            view;
        });
    }
    return _imgView;
}


-(CABasicAnimation *)animation{
    if (!_animation) {
        _animation = [CABasicAnimation animKeyPath:kTransformRotationZ duration:3 fromValue:nil toValue:@(M_PI*2.0) autoreverses:NO repeatCount:CGFLOAT_MAX];

    }
    return _animation;
}

@end
