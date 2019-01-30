
//
//  BNGView.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNGView.h"

#import "BNGloble.h"
#import "BNCategory.h"
#import "BNKit.h"

NSString * const kGview_items = @"kGview_items";
NSString * const kGview_numberOfRow = @"kGview_numberOfRow";
NSString * const kGview_itemHeight = @"kGview_itemHeight";
NSString * const kGview_padding = @"kGview_padding";
NSString * const kGview_type = @"kGview_type";
NSString * const kGview_isSingle = @"kGview_isSingle";
NSString * const kGview_itemsSelected = @"kGview_itemsSelected";

@interface BNGView ()

@property (nonatomic, strong) NSMutableArray * viewList;

@end

@implementation BNGView

+ (instancetype)viewRect:(CGRect)rect params:(NSDictionary *)params{
    BNGView * view = [[self alloc]initWithFrame:rect];
    view.params = params;
    
    return view;
}

-(void)setParams:(NSDictionary *)params{
    _params = params;
    
    NSParameterAssert([params.allKeys containsObject:kGview_items]);
    NSParameterAssert([params.allKeys containsObject:kGview_numberOfRow]);

    
    self.type = @0;
    self.isSingle = YES;
    self.items = params[kGview_items];
    self.numberOfRow = [params[kGview_numberOfRow] integerValue];
    if ([params.allKeys containsObject:kGview_type]) self.type = params[kGview_type];
    if ([params.allKeys containsObject:kGview_isSingle]) self.isSingle = [params[kGview_isSingle] boolValue];
    if ([params.allKeys containsObject:kGview_padding]) self.padding = [params[kGview_padding] floatValue];
    if ([params.allKeys containsObject:kGview_itemHeight]) self.itemHeight = [params[kGview_itemHeight] floatValue];
    if ([params.allKeys containsObject:kGview_itemsSelected]) self.selectedList = params[kGview_itemsSelected];

    NSInteger rowCount = self.items.count % self.numberOfRow == 0 ? self.items.count/self.numberOfRow : self.items.count/self.numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(self.frame) - (self.numberOfRow - 1)*self.padding)/self.numberOfRow;
    self.itemHeight = self.itemHeight == 0.0 ? itemWidth : self.itemHeight;
    CGFloat height = rowCount * self.itemHeight + (rowCount - 1) * self.padding;
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height);
    
    self.itemSize = CGSizeMake(itemWidth, self.itemHeight);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    self.viewList = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i< _items.count; i++) {
        
        CGFloat w = self.itemSize.width;
        CGFloat h = self.itemSize.height;
        CGFloat x = (i % _numberOfRow) * (w + _padding);
        CGFloat y = (i / _numberOfRow) * (h + _padding);
        
        NSString * title = _items[i];
        CGRect itemRect = CGRectMake(x, y, w, h);
        
        UIView * view = nil;
        switch ([_type integerValue]) {
            case 0://uibutton
            {
                view = [UIView createBtnRect:itemRect title:title font:16 image:nil tag:kTAG_VIEW+i type:@11];
                
                BOOL isSelected = [_selectedList[view.tag - kTAG_VIEW] boolValue];
                ((UIButton *)view).selected = isSelected;
                
                @weakify(self)
                [view addActionHandler:^(id obj, id item, NSInteger idx) {
                    @strongify(self)
                    UIButton * sender = item;
                    sender.selected = !sender.selected;
                    [self.selectedList replaceObjectAtIndex:idx withObject:@(sender.selected)];
                    [self hanleActionView:item isSingle:self.isSingle];
                    //传递数据
                    if (self.block) {
                        self.block(self, sender, idx);
                    }
                }];
            }
                break;
            case 1://UIImageVIew
            {
                view = [[UIImageView alloc]initWithFrame:itemRect];
                view.tag = kTAG_VIEW + i;
                UIImageView * imgView = (UIImageView *)view;
                [imgView loadImage:title defaultImg:kIMG_defaultFailed_S];
                
                BOOL isSelected = [_selectedList[view.tag - kTAG_VIEW] boolValue];
                ((UIImageView *)view).selected = isSelected;
                [self handleViewSelected:view];

                @weakify(self)
                [view addActionHandler:^(id obj, id item, NSInteger idx) {
                    @strongify(self)

                    UIImageView * sender = item;
                    sender.selected = !sender.selected;
                    [self handleViewSelected:item];
                    
                    [self.selectedList replaceObjectAtIndex:idx withObject:@(((UIImageView *)item).selected)];
                    [self hanleActionView:item isSingle:self.isSingle];

                    //传递数据
                    if (self.block) {
                        self.block(self, item, idx);
                        
                    }
                    
                }];
            }
                break;
            case 2://UILabel
            {
                view = ({
                    UILabel * view = [UIView createLabelRect:itemRect text:title font:16 tag:i type:@0];
                    view.textAlignment = NSTextAlignmentCenter;
                    view;
                });
                BOOL isSelected = [_selectedList[view.tag - kTAG_VIEW] boolValue];
                ((UILabel *)view).selected = isSelected;
                [self handleViewSelected:view];

                @weakify(self)
                [view addActionHandler:^(id obj, id item, NSInteger idx) {
                    @strongify(self)
                    UILabel * sender = item;
                    sender.selected = !sender.selected;
                    [self handleViewSelected:item];
                    
                    [self.selectedList replaceObjectAtIndex:idx withObject:@(((UILabel *)item).selected)];
                    [self hanleActionView:item isSingle:self.isSingle];

                    //传递数据
                    if (self.block) {
                        self.block(self, item, idx);
                        
                    }
                }];
                
            }
                break;
            case 3:
            {
                NSDictionary * dict = @{
                                        kRadio_title : title,
                                        kRadio_imageN : @"btn_selected_NO.png",
                                        kRadio_imageH : @"btn_selected_YES.png",
                                        
                                        kRadio_textColorH : UIColor.themeColor,
                                        kRadio_textColorN : UIColor.grayColor,
                                        
                                        };
                view = [[BNRadioView alloc]initWithFrame:itemRect attDict:dict isSelected:NO];
                view.tag = kTAG_VIEW + i;
                
                BOOL isSelected = [_selectedList[view.tag - kTAG_VIEW] boolValue];
                ((BNRadioView *)view).isSelected = isSelected;
                
                @weakify(self)
                ((BNRadioView *)view).block = ^(BNRadioView *radioView, UIView *itemView, BOOL isSelected) {
                    @strongify(self)

                    NSInteger index = view.tag - kTAG_VIEW;
                    [self.selectedList replaceObjectAtIndex:index withObject:@(radioView.isSelected)];
                    //传递数据
                    if (self.block) {
                        self.block(self, radioView, index);
                        
                    }
                };
            }
                break;
            default:
                break;
        }
//        view.backgroundColor = UIColor.randomColor;
        [self addSubview:view];
        [self.viewList addObject:view];
        
//        [view getViewLayer];
    }
}


- (void)handleViewSelected:(id)view{
    
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel * obj = view;
        if (obj.selected) {
            obj.textColor = UIColor.whiteColor;
            obj.backgroundColor = UIColor.themeColor;
        } else {
            obj.textColor = UIColor.blackColor;
            obj.backgroundColor = UIColor.whiteColor;
        }
        
    }
    else if ([view isKindOfClass:[UIImageView class]]) {
        UIImageView * obj = view;
        if (obj.selected) {
            obj.layer.borderColor = UIColor.themeColor.CGColor;
            obj.layer.borderWidth = 2;
        } else {
            obj.layer.borderColor = UIColor.clearColor.CGColor;
            obj.layer.borderWidth = 0;
        }
    }
}

- (void)hanleActionView:(UIView *)view isSingle:(BOOL)isSingle{
    if (isSingle == NO) {
        return;
    }
    
    switch ([self.type integerValue]) {
        case 0:
        {
            if (self.viewList.count == 1) {
                UIButton * sender = [self.viewList firstObject];
                [_selectedList replaceObjectAtIndex:0 withObject:@(sender.selected)];
                return;
            }

            for (NSInteger i = 0; i < self.viewList.count; i++) {
                UIButton * sender = self.viewList[i];
                if (sender.tag == view.tag) {
                    [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                    continue;
                }
                sender.selected = NO;
                [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                
            }
          
        }
            break;
        case 1:
        {
            if (self.viewList.count == 1) {
                UIImageView * sender = [self.viewList firstObject];
                [_selectedList replaceObjectAtIndex:0 withObject:@(sender.selected)];
                return;
            }
            
            for (NSInteger i = 0; i < self.viewList.count; i++) {
                UIImageView * sender = self.viewList[i];
                if (sender.tag == view.tag) {
                    [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                    continue;
                }
                sender.selected = NO;
                [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                
            }
        }
            break;
        case 2:
        {
            if (self.viewList.count == 1) {
                UILabel * sender = [self.viewList firstObject];
                [_selectedList replaceObjectAtIndex:0 withObject:@(sender.selected)];
                return;
            }
            
            for (NSInteger i = 0; i < self.viewList.count; i++) {
                UILabel * sender = self.viewList[i];
                if (sender.tag == view.tag) {
                    [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                    continue;
                }
                sender.selected = NO;
                [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                
            }
        }
            break;
        case 3:
        {
            if (self.viewList.count == 1) {
                BNRadioView * sender = [self.viewList firstObject];
                [_selectedList replaceObjectAtIndex:0 withObject:@(sender.selected)];
                return;
            }
            
            for (NSInteger i = 0; i < self.viewList.count; i++) {
                BNRadioView * sender = self.viewList[i];
                if (sender.tag == view.tag) {
                    [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                    continue;
                }
                sender.selected = NO;
                [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
                
            }
        }
            break;
        default:
            break;
    }
    
    
    
    
}

@end
