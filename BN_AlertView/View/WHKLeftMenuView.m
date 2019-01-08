
//
//  WHKLeftMenuView.m
//  WeiHouBao
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKLeftMenuView.h"

@interface WHKLeftMenuView()

@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) UIView *containView;

@property(nonatomic,strong) UIView *scrollView;

@end

@implementation WHKLeftMenuView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIWindow *window = UIApplication.sharedApplication.keyWindow;

        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.maskView addGestureRecognizer:tap];
        
        
        CGFloat menuWidth = CGRectGetWidth(window.frame)* kRatio_LeftMenu;
        self.frame = CGRectMake(-menuWidth, 0, menuWidth, CGRectGetHeight(window.frame));
        self.backgroundColor = [UIColor greenColor];

    }
    
    return self;
    
}


-(void)show{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self];

    CGRect tempFrame = self.frame;
    tempFrame.origin.x = CGRectGetMinX(self.frame) + CGRectGetWidth(self.frame);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.maskView.alpha = 0.5;
        self.frame = tempFrame;

    } completion:nil];
    
}

-(void)dismiss{
    
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = CGRectGetMinX(self.frame) - CGRectGetWidth(self.frame);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.maskView.alpha = 0;
        self.frame = tempFrame;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
        
    }];

}

@end
