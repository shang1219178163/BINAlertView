//
//  BNItemsView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNItemsView.h"
#import "UIControl+Helper.h"

@interface BNItemsView()

@property (nonatomic, strong) NSMutableArray *itemList;

@end

@implementation BNItemsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 5;
        _numberOfRow = 3;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_items != nil) {
        [self setupConstraint];
    }
}

- (void)setupConstraint{
    NSInteger rowCount = _items.count%_numberOfRow == 0 ? _items.count/_numberOfRow : _items.count/_numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(self.bounds) - (_numberOfRow - 1)*_padding)/_numberOfRow;
    CGFloat itemHeight = (CGRectGetHeight(self.bounds) - (rowCount - 1)*_padding)/rowCount;
    [_items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = (idx % _numberOfRow) * (itemWidth + _padding);
        CGFloat y = (idx / _numberOfRow) * (itemHeight + _padding);
        
        CGRect itemRect = CGRectMake(x, y, itemWidth, itemHeight);
        UIButton *view = self.itemList[idx];
        view.frame = itemRect;
    }];
}

//- (void)setupConstraint{
//    NSInteger rowCount = _items.count%_numberOfRow == 0 ? _items.count/_numberOfRow : _items.count/_numberOfRow + 1;
//    CGFloat itemWidth = (CGRectGetWidth(self.bounds) - (_numberOfRow - 1)*_padding)/_numberOfRow;
//    CGFloat itemHeight = (CGRectGetHeight(self.bounds) - (rowCount - 1)*_padding)/rowCount;
//    [_items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat x = (idx % _numberOfRow) * (itemWidth + _padding);
//        CGFloat y = (idx / _numberOfRow) * (itemHeight + _padding);
//
//        CGRect itemRect = CGRectMake(x, y, itemWidth, itemHeight);
//        UIButton *view = [self createBtnRect:itemRect title:obj tag:idx];
//        view.backgroundColor = UIColor.themeColor;
//        [view addActionHandler:^(UIControl * _Nonnull obj) {
//            if (self.block) {
//                self.block(self, (UIButton *)obj);
//            }
//        } forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:view];
//    }];
//}

- (void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    
    [self.itemList removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *view = [self createBtnRect:CGRectZero title:obj tag:idx];
        [view addActionHandler:^(UIControl * _Nonnull control) {
            if (self.block) {
                self.block(self, (UIButton *)control);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view];
        
        [self.itemList addObject:view];
    }];
}

- (NSMutableArray *)itemList{
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

#pragma mark - -funtions

- (UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag{
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.imageView.contentMode = UIViewContentModeScaleAspectFit;
    view.frame = rect;
    [view setTitle:title forState:UIControlStateNormal];
    view.titleLabel.adjustsFontSizeToFitWidth = true;
    [view setExclusiveTouch:false];
    view.tag = tag;
    
    return view;
}

@end
