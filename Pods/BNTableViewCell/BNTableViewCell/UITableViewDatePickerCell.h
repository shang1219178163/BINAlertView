//
//  UITableViewDatePickerCell.h
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNDatePicker.h"

/**
 日期选择(默认)
 */
@interface UITableViewDatePickerCell : UITableViewCell

@property (nonatomic, strong) BNDatePicker * datePicker;

@property (nonatomic, strong) void(^block)(UITableViewDatePickerCell *view, NSString * dateStr);

@end
