//
//  BNDatePicker.h
//  BINView
//
//  Created by BIN on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//
/**
一句话调用
[self createDatePick:nil tag:kTAG_DATE_PICKER];

#pragma mark - picker
- (void)createDatePick:(id)date tag:(NSInteger)tag{
    [self.view endEditing:YES];
    
    BNDatePicker *datePicker = [[BNDatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate = NSDate.distantPast;
    datePicker.maximumDate = [NSDate date];
    //    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = [NSLocale currentLocale];
    datePicker.title = @"请选择时间";
    datePicker.tag = tag;
 
    if ([date isKindOfClass:[NSString class]]) date = [NSDate dateWithString:date];
    datePicker.date = data ? data: [NSDate date];
    //    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [datePicker show];
    datePicker.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {

        NSString * dateStr = [self stringWithDate:datePicker.date];
        DDLog(@"dateStr_%@_%ld",dateStr,btnIndex);
        if (btnIndex == 1) {
            [self.view endEditing:YES];
            self.textField.text = dateStr;//
            
            
        }
    };
}
*/
 
#import <UIKit/UIKit.h>

typedef void(^BlockDatePicker)(UIDatePicker *datePicker,NSInteger btnIndex);

@interface BNDatePicker : UIDatePicker

@property (nonatomic, copy) void(^block)(UIDatePicker *datePicker,NSInteger btnIndex);

@property (nonatomic, strong) NSString *title;

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString*)confirmButtonTitle;

-(void)show;

-(void)dismiss;

@end
