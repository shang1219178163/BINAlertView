//
//  BNAlertViewOne.h
//  BINAlertView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNAlertViewOne : UIView

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray * dataList;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSDictionary *dic;//添加到cell上的数据源

@property (nonatomic, copy) void (^block)(BNAlertViewOne * view,NSIndexPath * indexPath);

- (void)show;
- (void)dismiss;

+(instancetype)showTitle:(NSString *)title dic:(NSDictionary *)dic handler:(void (^)(BNAlertViewOne * view,NSIndexPath * indexPath))handler;

@end
