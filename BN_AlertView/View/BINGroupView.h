//
//  BINGroupView.h
//  BN_AlertViewZero
//
//  Created by hsf on 2018/3/23.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BINGroupView : UIView

@property (nonatomic, strong) NSArray * items;
//@property (nonatomic, strong) UILabel * labelTitle;
//@property (nonatomic, strong) UILabel * labelTitle;

//@property (nonatomic, strong) NSArray * selectedList;

//@property (nonatomic, assign) NSInteger selectedIndex;
//@property (nonatomic, strong) UIColor * colorNormal;
//@property (nonatomic, strong) UIColor * colorSelected;

@property (nonatomic, strong) UIColor * colorBackNormal;
@property (nonatomic, strong) UIColor * colorBackSelected;
//@property (nonatomic, assign) BOOL imgViewWidth;
//+ (BINGroupView *)labWithImage:(id)image;

@property (nonatomic, assign) BOOL isOnlyOne;


@property (nonatomic, copy) void (^viewBlock)(BINGroupView * groupView, id selectedItems, NSString *title, NSInteger lastIdx);

- (id)initRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

+ (BINGroupView *)viewRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

@end
