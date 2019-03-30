//
//  BNTopSheetView.h
//  BNAlertView
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 导航栏点击出现下拉菜单
 */
@interface BNTopSheetView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UIView * containView;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * list;

@property (nonatomic, strong) NSIndexPath * indexP;
@property (nonatomic, strong) UIViewController * parController;

@property (nonatomic, copy) UITableViewCell *(^blockCellForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void(^blockDidSelectRow)(UITableView* tableView, NSIndexPath* indexPath);

- (void)setupTitleView;

- (void)show:(UIViewController *)inController;
- (void)dismiss;

@end
