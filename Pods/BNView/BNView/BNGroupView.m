
//
//  BNGroupView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNGroupView.h"

#import "BNGloble.h"
#import "BNCategory.h"
#import "BNKit.h"

@interface BNGroupView ()

@property (nonatomic, strong ,readwrite) NSMutableArray * selectedList;

@end

@implementation BNGroupView

-(NSMutableArray *)selectedList{
    if (!_selectedList) {
        _selectedList = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _selectedList;
    
}

+ (BNGroupView *)viewRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList{
    BNGroupView *view = [[BNGroupView alloc]initRect:rect items:items numberOfRow:numberOfRow itemHeight:itemHeight padding:padding selectedList:selectedList];
    return view;
}


- (id)initRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList{
    self = [super init];
    if (self) {
        _items = items;
        
        [self.selectedList removeAllObjects];
        [self.selectedList addObjectsFromArray:selectedList];
        
        //    CGFloat padding = 15;
        //    CGFloat viewHeight = 30;
        //    NSInteger numberOfRow = 4;
        NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
        //
        self.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * itemHeight + (rowCount - 1) * padding);
//        self.backgroundColor = UIColor.greenColor;

        CGSize viewSize = CGSizeMake((CGRectGetWidth(self.frame) - (numberOfRow-1)*padding)/numberOfRow, itemHeight);
        for (NSInteger i = 0; i< items.count; i++) {
            
            CGFloat w = viewSize.width;
            CGFloat h = viewSize.height;
            CGFloat x = (w + padding) * (i % numberOfRow);
            CGFloat y = (h + padding) * (i / numberOfRow);
            
            NSString * title = items[i];
            CGRect btnRect = CGRectMake(x, y, w, h);
            
     
            NSDictionary * dict = @{
                                    kRadio_title : title,
                                    kRadio_imageN : @"btn_selected_NO.png",
                                    kRadio_imageH : @"btn_selected_YES.png",
                                    
                                    kRadio_textColorH : UIColor.themeColor,
                                    kRadio_textColorN : UIColor.grayColor,
                                    
                                    };
            BNRadioView * view = [[BNRadioView alloc]initWithFrame:btnRect attDict:dict isSelected:NO];
            view.tag = kTAG_VIEW + i;
            view.isSelected = [_selectedList containsObject:@(view.tag - kTAG_VIEW)] ? YES : NO;
            
            [self addSubview:view];
            view.block = ^(BNRadioView *radioView, UIView *itemView, BOOL isSelected) {
//                DDLog(@"_%@_%@",@(tag),@(isSelected));
                [self handleActionView:radioView tag:itemView.tag isSelected:isSelected];
                
            };
            
        }
    }
    return self;
}

-(void)setIsOnlyOne:(BOOL)isOnlyOne{
    _isOnlyOne = isOnlyOne;
    if (isOnlyOne  && self.selectedList.count > 1) {
        //        NSAssert(isOnlyOne  && self.selectedList.count == 1, @"isOnlyOne = yes代表单选");
        self.selectedList = [NSMutableArray arrayWithObject:[self.selectedList lastObject]];
        for (BNRadioView *view in self.subviews) {
            view.isSelected = [self.selectedList containsObject:@(view.tag - kTAG_VIEW)] ? YES : NO;
            
        }
    }
}

- (void)handleActionView:(BNRadioView *)radioView tag:(NSInteger)tag isSelected:(BOOL)isSelected{
    
    if (self.isOnlyOne == NO) {
        if(radioView.isSelected == NO && [self.selectedList containsObject:@(tag - kTAG_VIEW)]) {
            [self.selectedList removeObject:@(tag - kTAG_VIEW)];
            
        }
        else if (radioView.isSelected  && ![self.selectedList containsObject:@(tag - kTAG_VIEW)]) {
            [self.selectedList addObject:@(tag - kTAG_VIEW)];
            
        }
       
    }
    else{
        
        if(radioView.isSelected == NO && [self.selectedList containsObject:@(tag - kTAG_VIEW)]) {
            [self.selectedList removeObject:@(tag - kTAG_VIEW)];

        }
        else if (radioView.isSelected  && ![self.selectedList containsObject:@(tag - kTAG_VIEW)]) {
            [self.selectedList removeAllObjects];
            [self.selectedList addObject:@(tag - kTAG_VIEW)];
            for (BNRadioView *view in self.subviews) {
                view.isSelected = [self.selectedList containsObject:@(view.tag - kTAG_VIEW)] ? YES : NO;

            }
        }
    }
    
    if (self.groupBlock) {
        self.groupBlock(self, self.selectedList, tag, self.isOnlyOne);
        
    }
}


-(void)setChooseList:(NSArray *)chooseList{
    [self.selectedList removeAllObjects];
    [self.selectedList addObjectsFromArray:chooseList];
    for (BNRadioView *view in self.subviews) {
        
        if ([[self.selectedList firstObject] isKindOfClass:[NSString class]]) {
            view.isSelected = [self.selectedList containsObject:[@(view.tag - kTAG_VIEW) stringValue]] ? YES : NO;

        } else {
            view.isSelected = [self.selectedList containsObject:@(view.tag - kTAG_VIEW)] ? YES : NO;

        }
    }
}

-(NSArray *)chooseList{
    return self.selectedList;
    
}



@end
