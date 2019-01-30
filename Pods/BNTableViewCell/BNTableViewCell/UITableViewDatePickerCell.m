//
//  UITableViewDatePickerCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewDatePickerCell.h"

#import "BNGloble.h"
#import "NSDateFormatter+Helper.h"
#import "UIView+Helper.h"
#import "NSString+Helper.h"
#import "BNTextField.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

/**
 文字+时间选择器
 */
@implementation UITableViewDatePickerCell

- (void)dealloc
{
    [self.labelLeft removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.labelLeft];
        [self.contentView addSubview:self.textField];
        
        self.textField.text = [[NSDateFormatter stringFromDate:NSDate.date format:kFormatDate] toDateShort];
        self.textField.placeholder = @"请选择";
        self.textField.textAlignment = NSTextAlignmentCenter;
        
        self.textField.rightView = [self.textField asoryView:kIMG_arrowDown];
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.textField.enabled = false;
        
        [self.labelLeft addObserver:self forKeyPath:@"text" options: NSKeyValueObservingOptionNew context:nil];

        @weakify(self);
        [self.contentView addGestureTap:^(UIGestureRecognizer *sender) {
            @strongify(self);
            [UIApplication.sharedApplication.keyWindow endEditing:true];
            [self.datePicker show];
            
        }];
    }
    return self;
}

#pragma mark -observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.labelLeft.attributedText = [self.labelLeft.text toAsterisk];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    [self.labelLeft sizeToFit];
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kX_GAP);
        make.size.equalTo(CGSizeMake(self.labelLeft.sizeWidth, kSizeArrow.height));
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelLeft);
        make.left.equalTo(self.labelLeft.right).offset(kPadding);
        make.right.equalTo(self.contentView).offset(-kX_GAP);
        make.height.equalTo(self.labelLeft);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BNDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = ({
            BNDatePicker *view = [[BNDatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
            view.minimumDate = NSDate.distantPast;
            view.maximumDate = NSDate.distantFuture;
            view.title = @"请选择时间";
            view.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {
                
                NSString * dateStr = [NSDateFormatter stringFromDate:datePicker.date format:kFormatDate];
                DDLog(@"dateStr_%@_%ld",dateStr,btnIndex);
                if (btnIndex == 1) {
                    self.textField.text = [dateStr toDateShort];
                    if (self.block) {
                        self.block(self, dateStr);
                    }
                }
            };
            view;
        });
    }
    return _datePicker;
}

@end
