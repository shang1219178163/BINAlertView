//
//  UITableViewAddressPickerCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewAddressPickerCell.h"

#import "BNGloble.h"
#import "NSString+Helper.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

#import "BNTextField.h"

@implementation UITableViewAddressPickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+地址选择器
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    
    self.textField.placeholder = @"请选择";
    self.textField.textAlignment = NSTextAlignmentCenter;
    
    self.textField.rightView = [self.textField asoryView:kIMG_location_H];
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    self.textField.delegate = self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.addressInfo = self.textField.text;
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    
    CGFloat XGap = kX_GAP;
    //    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    
    //控件1
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    //控件2
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMidY(self.contentView.frame) - textFieldH/2.0, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.labelLeft.frame) - padding - XGap, textFieldH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[[self superview] superview] endEditing:YES];
    [self createPickView:self.addressInfo tag:textField.tag];
    return NO;
    
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//
//
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [[[self superview] superview] endEditing:YES];
//    return YES;
//}

#pragma mark - - BNDatePicker
- (void)createPickView:(id)date tag:(NSInteger)tag{
    BNPickerViewAddress *pickerView = self.pickerAddress;
    
    if([self.addressInfo validObject]) [pickerView actionSelectAddress:self.addressInfo];
    [pickerView show];
    pickerView.block = ^(UIPickerView *pickerView, NSString *address, NSInteger btnIndex) {
        if (btnIndex == 1) {
            if (btnIndex == 1) {
                self.textField.text = address;
                if (self.block) {
                    self.block(self, address);
                }
            }
        }
    };
}

#pragma mark - -layz

-(BNPickerViewAddress *)pickerAddress{
    if (!_pickerAddress) {
        _pickerAddress =({
            BNPickerViewAddress *view = [[BNPickerViewAddress alloc]initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
            view.title = @"请选择";
            
            view;
        });
    }
    return _pickerAddress;
    
}

@end
