//
//  BN_AlertViewOne.h
//  BINAlertView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_AlertViewOne : UIView

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, copy) void (^block)(BN_AlertViewOne * view,NSIndexPath * indexPath);

- (void)show;
- (void)dismiss;

@end
