//
//  UITableViewFortyThreeCell.m
//  
//
//  Created by BIN on 2017/11/30.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewFortyThreeCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"

#import "BNTextField.h"

@interface UITableViewFortyThreeCell ()
 

@end

@implementation UITableViewFortyThreeCell

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
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    
    //控件1
    CGRect titleRect = CGRectMake(YGap, YGap, labLeftSize.width, lableLeftH);
    //控件2
    CGRect titleSubRect = CGRectMake(CGRectGetMaxX(titleRect) + padding, YGap, kScreenWidth - YGap - CGRectGetMaxX(titleRect) - padding, textFieldH);
    
    self.labelLeft.frame = titleRect;
    self.textField.frame = titleSubRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

