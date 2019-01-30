//
//  BNTurnView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNTurnView : UIView

@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) NSArray *list;

@property (nonatomic,assign) CGFloat interval;

- (void)start;

@end
