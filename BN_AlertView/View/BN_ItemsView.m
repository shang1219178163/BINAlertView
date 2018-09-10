//
//  BN_ItemsView.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_ItemsView.h"

@implementation BN_ItemsView

+ (BN_ItemsView *)viewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler{
    
    BN_ItemsView * view = [[self alloc]initWithFrame:rect];
    view.items = items;
    view.numberOfRow = numberOfRow;
    view.itemHeight = itemHeight;
    view.padding = padding;
    view.type = type;
    view.blockView = handler;
    
    return view;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //    CGFloat padding = 10;
    //    NSInteger numberOfRow = 4;
    _numberOfRow = _numberOfRow > 0 ? _numberOfRow : 4;
    _padding = _padding > 0 ? _padding : 10;
    _type = _type ? _type : @0;
    
    
    NSInteger rowCount = _items.count % _numberOfRow == 0 ? _items.count/_numberOfRow : _items.count/_numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(self.frame) - (_numberOfRow-1)*_padding)/_numberOfRow;
    _itemHeight = _itemHeight == 0.0 ? itemWidth : _itemHeight;;
    //
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), rowCount * _itemHeight + (rowCount - 1) * _padding);
    self.backgroundColor = [UIColor orangeColor];
    
    for (NSInteger i = 0; i< _items.count; i++) {
        
        CGFloat w = itemWidth;
        CGFloat h = _itemHeight;
        CGFloat x = (i % _numberOfRow) * (w + _padding);
        CGFloat y = (i / _numberOfRow) * (h + _padding);
        
        NSString * title = _items[i];
        CGRect itemRect = CGRectMake(x, y, w, h);
        
        UIView * view = nil;
        switch ([_type integerValue] ) {
            case 0://uibutton
            {
                view = [UIView createBtnWithRect:itemRect title:title font:15 image:nil tag:kTAG_BTN+i patternType:@"5" target:nil aSelector:nil];
            }
                break;
            case 1://UIImageVIew
            {
                view = [UIView createImageViewWithRect:itemRect image:title tag:kTAG_IMGVIEW+i patternType:@"0"];
                
            }
                break;
            case 2://UILabel
            {
                view = [UIView createLabelWithRect:itemRect text:title textColor:nil tag:kTAG_LABEL+i patternType:@"0" font:15 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
                
            }
                break;
            default:
                break;
        }
        [self addSubview:view];
        [view addActionHandler:^(id obj, id item, NSInteger idx) {
            if (self.blockView) {
                self.blockView(obj, item, idx);
                
            }
        }];
    }
}
/*
+ (BN_ItemsView *)viewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler{

    BN_ItemsView * itemsView = [[self alloc]initWithRect:rect items:items numberOfRow:numberOfRow itemHeight:itemHeight padding:padding type:type handler:handler];
    return itemsView;
}
    
- (instancetype)initWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler{

    self = [super initWithFrame:rect];
    if (self) {
        _items = items;
        _numberOfRow = numberOfRow;
        _itemHeight = itemHeight;
        _padding = padding;
        _type = type;
        _block = handler;
        
    //    CGFloat padding = 10;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
        NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
        CGFloat itemWidth = (CGRectGetWidth(rect) - (numberOfRow-1)*padding)/numberOfRow;
        itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
        //
        self.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * itemHeight + (rowCount - 1) * padding);
        self.backgroundColor = [UIColor orangeColor];
        
        for (NSInteger i = 0; i< items.count; i++) {
            
            CGFloat w = itemWidth;
            CGFloat h = itemHeight;
            CGFloat x = (i % numberOfRow) * (w + padding);
            CGFloat y = (i / numberOfRow) * (h + padding);
            
            NSString * title = items[i];
            CGRect itemRect = CGRectMake(x, y, w, h);
            
            UIView * view = nil;
            switch ([type integerValue] ) {
                case 0://uibutton
                {
                    view = [UIView createBtnWithRect:itemRect title:title font:15 image:nil tag:kTAG_BTN+i patternType:@"5" target:nil aSelector:nil];
                }
                    break;
                case 1://UIImageVIew
                {
                    view = [UIView createImageViewWithRect:itemRect image:title tag:kTAG_IMGVIEW+i patternType:@"0"];
                    
                }
                    break;
                case 2://UILabel
                {
                    view = [UIView createLabelWithRect:itemRect text:title textColor:nil tag:kTAG_LABEL+i patternType:@"0" font:15 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
                    
                }
                    break;
                default:
                    break;
            }
            [self addSubview:view];
            [view addActionHandler:^(id obj, id item, NSInteger idx) {
                handler(obj, item, idx);
                
            }];
            
        }
    }
    return self;
}
 
 */

@end
