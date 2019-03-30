//
//  BN_AlertView.h
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_AlertView : UIView

@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, copy) void (^block)(BN_AlertView * view,NSIndexPath * indexPath);

- (void)show;
- (void)dismiss;

@end
