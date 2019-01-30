//
//  BNGView.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kGview_items ;
FOUNDATION_EXPORT NSString * const kGview_numberOfRow ;
FOUNDATION_EXPORT NSString * const kGview_itemHeight ;
FOUNDATION_EXPORT NSString * const kGview_padding ;
FOUNDATION_EXPORT NSString * const kGview_type ;
FOUNDATION_EXPORT NSString * const kGview_isSingle ;
FOUNDATION_EXPORT NSString * const kGview_itemsSelected ;

@interface BNGView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) NSMutableArray * selectedList;

@property (nonatomic, strong) NSDictionary * params;
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, copy) void(^block)(BNGView * view, id item, NSInteger idx);

+ (instancetype)viewRect:(CGRect)rect params:(NSDictionary *)params;

@end
