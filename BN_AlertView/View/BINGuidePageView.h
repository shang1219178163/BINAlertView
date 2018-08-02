//
//  BINGuidePageView.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/22.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockHandleIndex)(NSInteger index);

@interface BINGuidePageView : UIView

//PageControl颜色
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIColor *nomalColor;

@property (nonatomic, copy) BlockHandleIndex blockIndex;

//isScrollOut为NO右滑到最后一页 引导页不消失(页面加跳转动作)
//isScrollOut为YES右滑到最后一页 引导页消失(直接进入主页面)
-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images isScrollOut:(BOOL)isScrollOut;

- (void)actionWithBlock:(BlockHandleIndex)index;

    
@end
