//
//  BN_AlertViewTwo.h
//  BINAlertView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_AlertViewTwo : UIView

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel * labelSub;

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, copy) void (^block)(BN_AlertViewTwo * view,NSInteger idx);

- (void)show;
- (void)dismiss;

@end
