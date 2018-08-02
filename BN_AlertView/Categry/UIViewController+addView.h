//
//  UIViewController+addView.h
//  WeiHouBao
//
//  Created by 晁进 on 17-7-25.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (addView)


-(void)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target aSelector:(SEL)aSelector isHidden:(BOOL)isHidden;

- (void)addLineViewWithRect:(CGRect)rect inView:(UIView *)inView;
- (void)addLineDashWithRect:(CGRect)rect tag:(NSInteger)tag inView:(UIView *)inView;

- (UITableViewCell *)getCellByClickView:(UIView *)view;

- (NSIndexPath *)getCellIndexPathByClickView:(UIView *)view  tableView:(UITableView *)tableView;

@end
