//
//  BNGroupView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//
/*
 单选框集合
 */

#import <UIKit/UIKit.h>

@class BNGroupView;

typedef void (^BlockGroupView)(BNGroupView * groupView, NSArray * selectedItems, NSInteger idx, BOOL isOnlyOne);

@interface BNGroupView : UIView

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) NSArray * chooseList;

@property (nonatomic, assign) BOOL isOnlyOne;

@property (nonatomic, copy) BlockGroupView groupBlock;

+ (BNGroupView *)viewRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

@end
