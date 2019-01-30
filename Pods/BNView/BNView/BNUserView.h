//
//  BNUserView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kH_userView = 50;

@interface BNUserView : UIView

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;

@property (nonatomic, strong) UILabel * labelRight;

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelLeftMark;
@property (nonatomic, strong) UILabel * labelLeftSub;
@property (nonatomic, strong) UILabel * labelLeftSubMark;


@end
