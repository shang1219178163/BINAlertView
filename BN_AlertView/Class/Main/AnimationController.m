//
//  AnimationController.m
//  BN_AlertView
//
//  Created by hsf on 2018/9/20.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "AnimationController.h"

#import "CAShapeLayer+Helper.h"

@interface AnimationController ()

@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Animation";
    
    [self createControls];
}

- (void)createControls{
    
    
    //定义一个CAShapeLayer
//    CAShapeLayer *myShapeLayer = ({
//
//        //初始化一个实例对象
//        CAShapeLayer *layer = CAShapeLayer.layer;
//
//        layer.frame        = CGRectMake(10, 10, 100, 100);  //设置大小
////        layer.position      = self.view.center;            //设置中心位置
//        layer.path          = [UIBezierPath bezierPathWithOvalInRect:layer.bounds].CGPath; //设置绘制路径
//        layer.strokeColor   = UIColor.redColor.CGColor;      //设置划线颜色
//        layer.fillColor     = UIColor.yellowColor.CGColor;   //设置填充颜色
//        layer.lineWidth     = 5;          //设置线宽
//        layer.lineCap       = @"round";    //设置线头形状
//        layer.strokeEnd     = 0.66;        //设置轮廓结束位置
//
//        layer;
//    });
    
    CGRect rect = CGRectMake(10, 10, 100, 100);
    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){{0, 0}, rect.size}].CGPath; //设置绘制路径
    CAShapeLayer *myShapeLayer = [CAShapeLayer layerWithRect:rect path:path strokeEnd:0.66 fillColor:UIColor.yellowColor strokeColor:UIColor.redColor lineWidth:5];

    //以subLayer的形式添加给self.view
    [self.view.layer addSublayer:myShapeLayer];
    
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //让其在z轴旋转
    animation.toValue = @(M_PI*2.0);//旋转角度
    animation.duration = 1;//旋转周期
    animation.cumulative = YES;//旋转累加角度
    animation.repeatCount = CGFLOAT_MAX;//旋转次数
    animation.autoreverses = NO;
    //锚点设置为图片中心，绕中心抖动
    //    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [myShapeLayer addAnimation:animation forKey:@"rotationAnimation"];
    return;
    
    //设置animation
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0.2;
    strokeAnimation.toValue = @0.8;
    strokeAnimation.duration = 1;
    strokeAnimation.autoreverses = YES;
    strokeAnimation.fillMode = kCAFillModeForwards;
    strokeAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = @2;
    lineWidthAnimation.toValue = @10;
    lineWidthAnimation.duration = 1;
    lineWidthAnimation.autoreverses = YES;

    
    CABasicAnimation *strokeColorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAnimation.fromValue = (id)UIColor.greenColor.CGColor;
    strokeColorAnimation.toValue = (id)UIColor.blueColor.CGColor;
    strokeColorAnimation.duration = 0.5;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation, strokeAnimation, lineWidthAnimation];
    group.duration = 1;
    group.repeatCount = CGFLOAT_MAX;//旋转次数

    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [myShapeLayer addAnimation:group forKey:@"groupAnimation"];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
