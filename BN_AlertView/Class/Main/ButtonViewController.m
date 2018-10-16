//
//  ButtonViewController.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/9.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "ButtonViewController.h"

@implementation ButtonViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 0, 90, 40);
    button.backgroundColor = UIColor.themeColor;
    [button setImage:[UIImage imageNamed:@"img_like_W"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"img_like_W"] forState:UIControlStateHighlighted];
    
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    [button setTitle:@"点赞" forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateHighlighted];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    //button标题的偏移量，这个偏移量是相对于图片的
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 60);
    
    //            [cell.contentView addSubview:button];
    
    
}

@end
