//
//  UITableViewFiftyNineCell.m
//  
//
//  Created by BIN on 2018/6/22.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewFiftyNineCell.h"

#import "BNGloble.h"
#import "NSDictionary+Helper.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIView+Helper.h"

#import "BNTextField.h"


@implementation UITableViewFiftyNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+pickerView(原生)
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    
    self.textField.placeholder = @"请选择";
    self.textField.rightView = [self.textField asoryView:kIMG_arrowDown];
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    [self.textField addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventEditingDidBegin];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
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

- (void)handleActionSender:(BNTextField *)textField{
    [[self superview]endEditing:YES];
    [self createAlertViewTag:textField.tag];
    
}

#pragma mark - - AlertView
- (void)createAlertViewTag:(NSInteger)tag{
    
    NSArray * array = [self.dic sortedValuesByKey];
    
    BNAlertViewOne * alertView = [[BNAlertViewOne alloc]init];
    alertView.data = @{
                       kItem_obj    :   array,
                       
                       };
    alertView.label.text = @"选择死淘原因";
    [alertView show];
    alertView.block = ^(BNAlertViewOne *view, NSIndexPath *indexPath) {
        DDLog(@"%@_%@_%@",@(indexPath.section),@(indexPath.row),array[indexPath.row]);
        self.textField.text = array[indexPath.row];
        if (self.block) {
            self.block(self, array[indexPath.row], indexPath);
        }
        
        
    };
    
}



@end
