//
//  BNGuideView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/22.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNGuideView : UIView

//PageControl颜色
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIColor *nomalColor;

@property (nonatomic, copy) void (^block)(NSInteger index);

//isScrollOut为NO右滑到最后一页 引导页不消失(页面加跳转动作)
//isScrollOut为YES右滑到最后一页 引导页消失(直接进入主页面)
-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images isScrollOut:(BOOL)isScrollOut;

    
@end
