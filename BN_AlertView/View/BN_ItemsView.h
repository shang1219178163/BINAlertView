//
//  BN_ItemsView.h
//  BINAlertView
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_ItemsView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, copy) void(^blockView)(id obj, id item, NSInteger idx);

+ (BN_ItemsView *)viewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler;



@end
