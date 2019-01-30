//
//  BNGroupViewZero.h
//  BINAlertView
//
//  Created by BIN on 2018/3/23.
//  Copyright © 2018年 SouFun. All rights reserved.
//

/*
 子视图为button
 */

#import <UIKit/UIKit.h>

@class BNGroupViewZero;

typedef void (^BNGroupViewZeroBlock)(BNGroupViewZero * groupView, id selectedItems, NSString *title, BOOL isOnlyOne);

@interface BNGroupViewZero : UIView

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) NSArray * chooseList;

@property (nonatomic, strong) UIColor * colorBackNormal;
@property (nonatomic, strong) UIColor * colorBackSelected;

@property (nonatomic, assign) BOOL isOnlyOne;

@property (nonatomic, copy) BNGroupViewZeroBlock viewBlock;

- (id)initRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

+ (BNGroupViewZero *)viewRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

@end
