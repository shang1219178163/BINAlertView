//
//  BN_TabBarView.h
//  BINAlertView
//
//  Created by hsf on 2018/3/29.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

static  CGFloat kH_topView = 44;//itemsView高度
static  CGFloat kH_slideView = 5;//指示器高度

@interface BN_TabBarView : UIView

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
///@brife 创建的items
@property (strong, nonatomic, readonly) NSArray *items;
///@brife 当前选中页数
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger selectedPage;

///@brife 下方的ScrollView
@property (nonatomic, strong) UIScrollView *scrollView;

///@brife 下方的表格数组
@property (nonatomic, strong) NSMutableArray *scrollTableViews;

+ (BN_TabBarView *)viewWithRect:(CGRect)frame items:(NSArray *)items;

@end
