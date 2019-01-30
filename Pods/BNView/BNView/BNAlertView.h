//
//  BNAlertView.h
//  BINAlertView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNAlertView : UIView

@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, copy) void (^block)(BNAlertView * view,NSIndexPath * indexPath);

- (void)show;
- (void)dismiss;

@end
