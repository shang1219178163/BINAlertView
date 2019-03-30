//
//  BINStarsView.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^BlockSelectedIndex)(NSInteger index);


@interface BINStarsView : UIView


@property (nonatomic, strong) UIColor * indicatorColor;
@property (nonatomic, strong) UIColor * titleColorSelected;
@property (nonatomic, strong) UIColor * gapLineColor;

@property (nonatomic, copy) BlockSelectedIndex blockIndex;

- (id)initWithFrame:(CGRect)frame StarCount:(NSInteger)starCount starNormal:(NSString *)starNormal starHighlight:(NSString *)starHighlight hasGesture:(BOOL)hasGesture target:(id)target aSelector:(SEL)aSelector;

- (void)actionWithBlock:(BlockSelectedIndex)selectedIndex;

@end
