//
//  UITableViewThirtyFiveCell.m
//  
//
//  Created by BIN on 2017/10/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThirtyFiveCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewThirtyFiveCell ()
 
@end

@implementation UITableViewThirtyFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1+空格+文字2(交易明细)
    /*
     -------------------------
     ---文字---  文字
     -------------------------
     */

    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize textSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    //文字+文字
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat labelHeight = kH_LABEL;
    
    //控件1
    CGRect labelLeftRect = CGRectMake(YGap*3, YGap, textSize.width+50, labelHeight);
    //控件2
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMaxX(labelLeftRect)+padding, CGRectGetMinY(labelLeftRect), CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(labelLeftRect) - padding - YGap*3, labelHeight);
    
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftMark.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
