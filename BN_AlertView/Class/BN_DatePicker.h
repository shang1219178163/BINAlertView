//
//  BINDataPicker.h
//  BINView
//
//  Created by hsf on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_DatePicker : UIDatePicker

@property (nonatomic, copy) void(^block)(UIDatePicker *datePicker,NSInteger btnIndex);

@property (nonatomic, strong) NSString *title;

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle;

-(void)show;

-(void)dismissDatePicker;

@end
