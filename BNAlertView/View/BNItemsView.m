//
//  BNItemsView.m
//  BNAlertViewZero
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BNItemsView.h"

//#import "BNCategory.h"
#import "UIView+Helper.h"

@interface BNItemsView()

@property (nonatomic, strong) NSMutableArray *itemList;

@end

@implementation BNItemsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfRow = 3;
        _padding = 5.0;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger rowCount = _items.count % _numberOfRow == 0 ? _items.count/_numberOfRow : _items.count/_numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(self.frame) - (_numberOfRow-1)*_padding)/_numberOfRow;
    CGFloat itemHeight = (CGRectGetHeight(self.frame) - (rowCount - 1)*_padding)/rowCount;
    //
    
    for (NSInteger i = 0; i< _items.count; i++) {
        CGFloat x = (i % _numberOfRow) * (itemWidth + _padding);
        CGFloat y = (i / _numberOfRow) * (itemHeight + _padding);
        CGRect itemRect = CGRectMake(x, y, itemWidth, itemHeight);
        
        UIButton * btn = self.itemList[i];
        btn.frame = itemRect;
    }
}
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
    [self removeAllSubViews];
    
    [_items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * btn = [self createBtnRect:CGRectZero title:obj tag:idx];
        [self addSubview:btn];
        [btn addActionHandler:^(UIControl * _Nonnull control) {
            if (self.block != nil) {
                self.block(self, (UIButton *)control);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.itemList addObject:btn];
    }];
}

- (UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag{
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.frame = rect;
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:UIColor.blackColor forState:UIControlStateNormal];

    view.titleLabel.font = [UIFont systemFontOfSize:16];
    view.titleLabel.adjustsFontSizeToFitWidth = YES;
    view.imageView.contentMode = UIViewContentModeScaleAspectFit;
    view.tag = tag;

    return view;
}
@end
