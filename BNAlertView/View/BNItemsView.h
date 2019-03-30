//
//  BNItemsView.h
//  BNAlertViewZero
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNItemsView : UIView

@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat padding;
//@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, copy) void(^block)(BNItemsView *view, UIButton * sender);

@end
