//
//  BNTabBarView.h
//  BINAlertView
//
//  Created by hsf on 2018/3/29.
//  Copyright © 2018年 SouFun. All rights reserved.
//
/*
 顶部UISegmentedControl
 */

#import <UIKit/UIKit.h>

@interface BNTabBarView : UIView

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

@property (nonatomic, strong) UITableView * tableView;

+ (BNTabBarView *)viewRect:(CGRect)frame items:(NSArray *)items;

@property (nonatomic, copy) void(^block)(BNTabBarView *view, UITableView * tableView, NSInteger idx);

@end
