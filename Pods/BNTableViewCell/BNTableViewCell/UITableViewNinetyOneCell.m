//
//  UITableViewNinetyOneCell.m
//  
//
//  Created by BIN on 2018/6/19.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewNinetyOneCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

#import "BNTextField.h"

@implementation UITableViewNinetyOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.labelRight];
    
    self.labelRight.font = [UIFont systemFontOfSize:kFZ_Second];
    self.labelRight.textAlignment = NSTextAlignmentLeft;
    self.labelRight.adjustsFontSizeToFitWidth = YES;
    
    self.textField.placeholder = @"请输入";
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.delegate = self;
    
    self.textField.layer.borderWidth = kW_LayerBorder;
    self.textField.layer.borderColor = UIColor.lightGrayColor.CGColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
        
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    
    CGSize textFieldSize = CGSizeMake(100, 30);
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - textFieldSize.height)*0.5;
    
    self.labelLeft.frame = CGRectMake(kX_GAP, YGap, labLeftSize.width, textFieldSize.height);
    self.textField.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - kX_GAP - textFieldSize.width, YGap, textFieldSize.width, textFieldSize.height);

    self.labelRight.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + kPadding, YGap, CGRectGetMinX(self.textField.frame) - CGRectGetMaxX(self.labelLeft.frame) - kPadding*2, textFieldSize.height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [[[self superview] superview] endEditing:YES];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(self, self.labelRight.text, textField.text);
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[[self superview] superview] endEditing:YES];
    return YES;
}

//限制长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) return YES;
    if (textField.text.length >= 4) {
        return NO;
        
    }
    return YES;
    
}
#pragma mark - -other

-(void)setString:(NSString *)string{
    _string = string;
    self.labelRight.text = string;
    if (self.block) {
        self.block(self, self.labelRight.text, self.textField.text);
    }
}



#pragma mark - -layz


@end
