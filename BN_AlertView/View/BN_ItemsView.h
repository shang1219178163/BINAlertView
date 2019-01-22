//
//  BN_ItemsView.h
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_ItemsView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, copy) void(^blockView)(id obj, id item, NSInteger idx);


@end
