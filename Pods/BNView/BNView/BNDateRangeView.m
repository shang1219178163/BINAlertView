//
//  BNDateRangeView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNDateRangeView.h"

#import "BNGloble.h"
#import "NSDateFormatter+Helper.h"
#import "UIView+Helper.h"
#import "NSString+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface BNDateRangeView()

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labStart;
@property (nonatomic, strong) UILabel * labEnd;
@property (nonatomic, strong) UILabel * labLine;

@end

@implementation BNDateRangeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labelLeft];
        [self addSubview:self.labStart];
        [self addSubview:self.labEnd];
        [self addSubview:self.labLine];
        
        self.dateStart = self.dateEnd = [[NSDateFormatter stringFromDate:NSDate.date format:kFormatDate] toDateShort];
                
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];

}

-(void)setupConstraint{
    [self.labelLeft sizeToFit];
    self.labelLeft.size = CGSizeMake(self.labelLeft.sizeWidth, 35);
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kX_GAP);
        make.size.equalTo(self.labelLeft.size);
    }];
    
    self.labStart.size = CGSizeMake(100, self.labelLeft.sizeHeight);
    [self.labStart makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.lessThanOrEqualTo(self.labelLeft.right).offset(30);
        make.size.equalTo(self.labStart.size);
    }];
    
    self.labLine.size = CGSizeMake(20, self.labelLeft.sizeHeight);
    [self.labLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.labStart.right).offset(20);
        make.size.equalTo(self.labLine.size);
    }];
    
    [self.labEnd makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.labLine.right).offset(20);
        make.size.equalTo(self.labStart.size);
    }];
    
}

- (void)setDateStart:(NSString *)dateStart{
    _dateStart = dateStart;
    self.labStart.text = [dateStart toDateShort];

}

- (void)setDateEnd:(NSString *)dateEnd{
    _dateEnd = dateEnd;
    self.labEnd.text = [dateEnd toDateShort];

}

#pragma mark - lazy

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [self createLabelRect:CGRectZero text:@"日期选择:" tag:0];
    }
    return _labelLeft;
}

- (UILabel *)labStart{
    if (!_labStart) {
        _labStart = [self createLabelRect:CGRectZero text:@"起始日期" tag:kTAG_LABEL];
        _labStart.textColor = UIColor.titleSubColor;
        @weakify(self);
        [_labStart addGestureTap:^(UIGestureRecognizer *sender) {
            @strongify(self);
            [self.datePicker show];
            
        }];
    }
    return _labStart;
}

- (UILabel *)labEnd{
    if (!_labEnd) {
        _labEnd = [self createLabelRect:CGRectZero text:@"截止日期" tag:kTAG_LABEL+1];
        _labEnd.textColor = UIColor.titleSubColor;
        @weakify(self);
        [_labEnd addGestureTap:^(UIGestureRecognizer *sender) {
            @strongify(self);
            [self.datePickerEnd show];
           
        }];
    }
    return _labEnd;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [self createLabelRect:CGRectZero text:@"-" tag:1];
    }
    return _labLine;
}

-(BNDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = ({
            BNDatePicker *view = [[BNDatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
            view.minimumDate = NSDate.distantPast;
            view.maximumDate = NSDate.distantFuture;
            view.title = @"请选择时间";
            view.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {
                NSString * dateStr = [NSDateFormatter stringFromDate:datePicker.date format:kFormatDate];
                self.dateStart = dateStr;
                if (self.block) {
                    self.block(self);
                }
            };
            view;
        });
    }
    return _datePicker;
}

-(BNDatePicker *)datePickerEnd{
    if (!_datePickerEnd) {
        _datePickerEnd = ({
            BNDatePicker *view = [[BNDatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
            view.minimumDate = NSDate.distantPast;
            view.maximumDate = NSDate.distantFuture;
            view.title = @"请选择时间";
            view.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {
                NSString * dateStr = [NSDateFormatter stringFromDate:datePicker.date format:kFormatDate];
                self.dateEnd = dateStr;
                if (self.block) {
                    self.block(self);
                }
            };
            view;
        });
    }
    return _datePickerEnd;
}

- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.font = [UIFont systemFontOfSize:16];
    view.textAlignment = NSTextAlignmentCenter;
    view.userInteractionEnabled = true;
    view.numberOfLines = 1;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.adjustsFontSizeToFitWidth = YES;
    //        label.backgroundColor = UIColor.greenColor;

    view.text = text;
    view.tag = tag;
    return view;
}

@end
