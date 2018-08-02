//
//  BINTabBarView.h
//  BINAlertView
//
//  Created by hsf on 2018/3/28.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

static  NSInteger kCount_Item = 3;//屏幕显示几个
static  CGFloat kH_topView = 60;//itemsView高度
static  CGFloat kH_slideView = 5;//指示器高度

@interface BINTabBarView : UIView

///@brife 创建的items
@property (strong, nonatomic, readonly) NSArray *items;

///@brife 当前选中页数
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger selectedPage;

///@brife 上方的ScrollView
@property (nonatomic, strong) UIScrollView *topScrollView;

///@brife 上方的按钮数组
@property (nonatomic, strong) NSMutableArray *itemViews;

///@brife 下面滑动的View
@property (nonatomic, strong) UIView *slideView;

///@brife 下方的ScrollView
@property (nonatomic, strong) UIScrollView *scrollView;

///@brife 下方的表格数组
@property (nonatomic, strong) NSMutableArray *scrollTableViews;

+ (BINTabBarView *)viewWithRect:(CGRect)frame items:(NSArray *)items;

@end
