//
//  BN_ItemsView.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_ItemsView.h"

#import "BN_Category.h"

@interface BN_ItemsView()

@property (nonatomic, strong) NSMutableArray *itemList;

@end

@implementation BN_ItemsView

- (NSMutableArray *)itemList{
    if (!_itemList) {
        _itemList = @[].mutableCopy;
    }
    return _itemList;
}




- (void)setItems:(NSArray *)items{
    _items = items;
    
    if (items == nil || items.count == 0) {
        return;
    }
    
    [self.itemList removeAllObjects];
    [self.subviews removeAllSubViews];
    
    self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }
    
    
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
                view = [UIView createBtnRect:itemRect title:title font:15 image:nil tag:kTAG_BTN+i type:@5 target:nil aSelector:nil];
            }
                break;
            case 1://UIImageVIew
            {
                view = [UIView createImgViewRect:itemRect image:title tag:kTAG_IMGVIEW+i type:@0];
                
            }
                break;
            case 2://UILabel
            {
                view = [UIView createLabelRect:itemRect text:title textColor:nil tag:kTAG_LABEL+i type:@0 font:15 backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
                
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


@end
