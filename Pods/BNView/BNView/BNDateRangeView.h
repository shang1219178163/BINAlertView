//
//  BNDateRangeView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BNDatePicker.h"

@interface BNDateRangeView : UIView

@property (nonatomic, copy) NSString *dateStart;
@property (nonatomic, copy) NSString *dateEnd;
@property (nonatomic, strong) BNDatePicker * datePicker;
@property (nonatomic, strong) BNDatePicker * datePickerEnd;

@property (nonatomic, strong, readonly) UILabel * labelLeft;
@property (nonatomic, strong) void(^block)(BNDateRangeView *view);

@end

