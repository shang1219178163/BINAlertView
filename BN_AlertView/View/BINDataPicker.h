//
//  BINDataPicker.h
//  BINView
//
//  Created by hsf on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockDatePicker)(UIDatePicker *datePicker,NSInteger btnIndex);

@interface BINDataPicker : UIDatePicker

@property (nonatomic, copy) BlockDatePicker blockDatePicker;
- (void)actionWithBlock:(BlockDatePicker)blockDatePicker;

@property (nonatomic, strong) NSString *title;

-(id)initWithCancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString*)confirmButtonTitle;

-(void)show;

-(void)dismissDatePicker;

@end
