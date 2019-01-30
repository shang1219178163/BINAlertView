
//
//  UITableViewThirtyFourCell.m
//  
//
//  Created by BIN on 2017/10/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThirtyFourCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"


@interface UITableViewThirtyFourCell ()

@end

@implementation UITableViewThirtyFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1+文字3
    //文字2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelRight];
    [self.contentView addSubview:self.labelLeftSub];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize textSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
    
    //文字1+文字3
    //文字2
    CGFloat YGap = kY_GAP/2;
    
    //控件3
    CGRect labelRightRect = CGRectMake(self.contentView.maxX - textSize.width - kX_GAP, YGap, textSize.width, kH_LABEL);
    //控件1
    CGRect labelLeftRect = CGRectMake(kX_GAP, YGap, CGRectGetMinX(labelRightRect) - kX_GAP - kPadding, kH_LABEL);
    //控件2
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), CGRectGetWidth(labelLeftRect), kH_LABEL);
    
    self.labelRight.frame = labelRightRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
