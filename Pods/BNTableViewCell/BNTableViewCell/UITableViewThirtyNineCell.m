//
//  UITableViewThirtyNineCell.m
//  
//
//  Created by BIN on 2017/11/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThirtyNineCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"

#import "BNTextField.h"

@interface UITableViewThirtyNineCell ()


@end

@implementation UITableViewThirtyNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字(BNTextField)
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //文字+文字
    //    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize labLeftSize = [self sizeWithText:@"一二三四五六:" font:self.labelLeft.font width:CGFLOAT_MAX];//待优化
    
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat lableLeftH = kH_LABEL;
    
    //控件1
    CGRect titleRect = CGRectMake(YGap, YGap, labLeftSize.width, lableLeftH);
    //控件2
    CGRect titleSubRect = CGRectMake(CGRectGetMaxX(titleRect) + padding, YGap, CGRectGetWidth(self.contentView.frame) - YGap - CGRectGetMaxX(titleRect) - padding, CGRectGetHeight(self.contentView.frame) - kY_GAP*2);
    
    self.labelLeft.frame = titleRect;
    self.textField.frame = titleSubRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
