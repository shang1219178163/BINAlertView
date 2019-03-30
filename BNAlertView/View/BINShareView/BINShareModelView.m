//
//  BINShareModelView.m
//  ShareInfo
//
//  Created by hsf on 2017/9/1.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "BINShareModelView.h"

#define kScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

#define kH_Icon 60
#define kW_icon 60
#define kH_Lab 18
#define kW_lab 60

@implementation BINShareModelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.frame = CGRectMake(0, 0, 48, 64);
//        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        imageView.layer.borderWidth = 0.5;
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapButtonView:)];
//        tap.numberOfTapsRequired = 1;
//        tap.numberOfTouchesRequired =1;
//        imageView.UserInteractionEnabled = YES;
//
//        [imageView addGestureRecognizer:tap];
//
//        self.img = imageView;
//        [self addSubview:self.img];
        CGFloat labelWidth = CGRectGetWidth(frame);
        CGFloat labelHeight = 18;
        
        CGFloat btnWidth = CGRectGetWidth(frame) > CGRectGetHeight(frame) ?  CGRectGetHeight(frame) - labelHeight : CGRectGetHeight(frame) - labelHeight;
        CGFloat btnHeight = btnWidth;
        
        CGFloat btnXGap = (labelWidth - btnWidth)/2.0;

        
        
        UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(btnXGap, 0, btnWidth, btnHeight);

        [shareBtn setTitle:@"0_0" forState:UIControlStateNormal];
        [shareBtn setTitle:@"0&0" forState:UIControlStateHighlighted];
//        [shareBtn addTarget:self action:@selector(shareBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        self.btn = shareBtn;
        [self addSubview:self.btn];
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, btnHeight, labelWidth, labelHeight)];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor lightGrayColor];
        
        self.titleLab = lab;
        [self addSubview:self.titleLab];
        
//        self.btn.layer.borderColor = [UIColor redColor].CGColor;
//        self.btn.layer.borderWidth = 1;
//        self.titleLab.layer.borderColor = [UIColor blueColor].CGColor;
//        self.titleLab.layer.borderWidth = 1;
        
    }
    return self;
}

@end

