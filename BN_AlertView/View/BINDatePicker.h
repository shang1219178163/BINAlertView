//
//  BINDatePicker.h
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
    
    BINDatePicker *datePicker = [[BINDatePicker alloc] initWithCancelButtonTitle:@"取消" confirmBtnTitle:@"确认"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate = [NSDate distantPast];
    datePicker.maximumDate = [NSDate date];
    //    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = [NSLocale currentLocale];
    datePicker.title = @"请选择时间";
    datePicker.tag = tag;
 
    if ([date isKindOfClass:[NSString class]]) date = [NSDate dateWithString:date];
    datePicker.date = data ? data: [NSDate date];
    //    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [datePicker show];
    [datePicker actionWithBlock:^(UIDatePicker *datePicker, NSInteger btnIndex) {
        NSString * dateStr = [self stringWithDate:datePicker.date];
        DDLog(@"dateStr_%@_%ld",dateStr,btnIndex);
        if (btnIndex == 1) {
            [self.view endEditing:YES];
            self.textField.text = dateStr;//
            
            
        }
    }];
}
*/
 
#import <UIKit/UIKit.h>

typedef void(^BlockDatePicker)(UIDatePicker *datePicker,NSInteger btnIndex);

@interface BINDatePicker : UIDatePicker

@property (nonatomic, copy) BlockDatePicker blockDatePicker;
- (void)actionWithBlock:(BlockDatePicker)blockDatePicker;

@property (nonatomic, strong) NSString *title;

-(id)initWithCancelButtonTitle:(NSString *)cancelButtonTitle confirmBtnTitle:(NSString*)confirmButtonTitle;

-(void)show;

-(void)dismissDatePicker;

@end
