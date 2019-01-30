//
//  BNStarsView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNStarsView : UIView

@property (nonatomic, assign) NSInteger starCount;
@property (nonatomic, assign) NSInteger starlightedCount;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSMutableArray * starMarr;

@property (nonatomic, copy) void (^block)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame StarCount:(NSInteger)starCount starlightedCount:(NSInteger)starlightedCount starNormal:(NSString *)starNormal starHighlight:(NSString *)starHighlight hasGesture:(BOOL)hasGesture;

@end
