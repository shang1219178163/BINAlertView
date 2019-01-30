
//
//  UITableViewSixCell.m
//  
//
//  Created by BIN on 2017/8/18.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewSixCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"

#import "BNTextField.h"

@implementation UITableViewSixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    //文字+文字(textField)
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.imgViewRight];

    
    self.textField.placeholder = @"请输入";
    self.textField.textAlignment = NSTextAlignmentCenter;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    
    CGSize arrowSize = CGSizeMake(25, 30);
    self.imgViewRight.frame = CGRectMake(self.contentView.maxX - arrowSize.width - kX_GAP, (self.contentView.maxY - arrowSize.height)/2.0, arrowSize.width, arrowSize.height);

    
    CGFloat lableLeftH = 30.0 , textFieldH = 30.0;
    
    //控件1
    self.labelLeft.frame = CGRectMake(kX_GAP, CGRectGetMinY(self.imgViewRight.frame), labLeftSize.width, lableLeftH);
    //控件2
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + kPadding, CGRectGetMinY(self.imgViewRight.frame), self.contentView.maxX - CGRectGetMaxX(self.labelLeft.frame) - kPadding - kX_GAP, textFieldH);
    if (!self.labelLeft.text && !self.labelLeft.attributedText) {
        self.textField.frame = CGRectMake(kX_GAP, CGRectGetMinY(self.imgViewRight.frame), self.contentView.maxX - kX_GAP*2, textFieldH);
        
    }
    
    if (self.imgViewRight.hidden == NO) {
        CGRect rect = self.textField.frame;
        rect.size.width -= (arrowSize.width+kPadding);
        self.textField.frame = rect;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
