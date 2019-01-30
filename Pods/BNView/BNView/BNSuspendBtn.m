//
//  BNSuspendView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/25.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNSuspendBtn.h"

/**
 控制器界面悬浮按钮
 */
@implementation BNSuspendBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        self.layer.zPosition = 1;//置顶（只是显示置顶，但响应事件会被后来者覆盖！）
        self.backgroundColor = UIColor.clearColor;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self setBackgroundImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];

        //创建移动手势事件
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionPan:)];
        pan.minimumNumberOfTouches = 1;
        pan.delaysTouchesEnded = true;
        pan.cancelsTouchesInView = true;
        [self addGestureRecognizer:pan];
    }
    return self;
}

-(void)setParController:(UIViewController *)parController{
    _parController = parController;
//    [parController.view addSubview:self];
}

- (void)handleActionPan:(UIPanGestureRecognizer *)recognizer{
    if (_isLock) {
        return;
    }
    //移动状态
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:recognizer.view.superview];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGRect superViewRect = self.parController.view.frame;
            CGPoint stopPoint = recognizer.view.center;
            if (stopPoint.x - CGRectGetWidth(self.frame)*0.5 - self.insets.left <= 0) {
                stopPoint = CGPointMake(CGRectGetWidth(self.frame)*0.5 + self.insets.left, stopPoint.y);
            }
            
            if (stopPoint.x + CGRectGetWidth(self.frame)*0.5 + self.insets.right >= CGRectGetWidth(superViewRect)) {
                stopPoint = CGPointMake(CGRectGetMaxX(superViewRect) - CGRectGetWidth(self.frame)*0.5 - self.insets.right, stopPoint.y);
            }
            
            if (stopPoint.y - CGRectGetHeight(self.frame)*0.5 - self.insets.top <= 0) {
                stopPoint = CGPointMake(stopPoint.x, CGRectGetHeight(self.frame)*0.5 + self.insets.top);
            }
            
            if (stopPoint.y + CGRectGetHeight(self.frame)*0.5 + self.insets.bottom >= CGRectGetHeight(superViewRect)) {
                stopPoint = CGPointMake(stopPoint.x, CGRectGetHeight(superViewRect) - CGRectGetHeight(self.frame)*0.5 - self.insets.bottom);
            }
            
            [UIView animateWithDuration:0.35 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
        default:
            break;
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view.superview];
}

@end
