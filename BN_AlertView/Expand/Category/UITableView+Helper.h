//
//  UITableView+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/2/28.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Helper)

-(void)logTableViewContentInset;

-(void)insertIndexPaths:(NSArray *)indexPaths rowAnimation:(UITableViewRowAnimation)rowAnimation;
-(void)deleteIndexPaths:(NSArray *)indexPaths rowAnimation:(UITableViewRowAnimation)rowAnimation;
-(void)reloadIndexPaths:(NSArray *)indexPaths rowAnimation:(UITableViewRowAnimation)rowAnimation;

-(void)deleteSectionIdxPath:(NSIndexPath *)idxPath rowAnimation:(UITableViewRowAnimation)rowAnimation;

-(void)cellAddCornerRadius:(CGFloat)cornerRadius cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
