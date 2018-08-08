//
//  BN_RangeDateView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

static  CGFloat kH_topView = 50;

@interface BN_RangeDateView : UIView

@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, strong, readonly) NSMutableArray *itemList;

@property (nonatomic, copy) NSString *dateStart;
@property (nonatomic, copy) NSString *dateEnd;
//@property (nonatomic, assign) BOOL isNorml;

@property (nonatomic, copy) void(^block)(BN_RangeDateView * view, NSString *dateStart,NSString *dateEnd);

@end
