//
//  UITableViewSixteenCell.m
//  
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewSixteenCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIView+Helper.h"

@interface UITableViewSixteenCell ()

@end

@implementation UITableViewSixteenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /**
     ---------------------------
     图像+姓名+已结N单
        +星星+信任值
     ---------------------------
     */
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.imgViewRight];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    [self.contentView addSubview:self.labelLeftSub];
    [self.contentView addSubview:self.labelLeftSubMark];
    
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    //
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize markSize = [self sizeWithText:self.labelLeftMark.text font:self.labelLeftMark.font width:CGFLOAT_MAX];
    CGSize markSubSize = [self sizeWithText:self.labelLeftSubMark.text font:self.labelLeftSubMark.font width:CGFLOAT_MAX];
    
    CGFloat YGap = 10;
    CGFloat heightImgView = CGRectGetHeight(self.contentView.frame) - YGap * 2;
    CGFloat heightLab = kH_LABEL_SMALL;
    CGFloat padding = YGap/4.0;
    
    //图片+文字+文字
    //    星星+文字
    CGSize imgViewSize = CGSizeMake(heightImgView, heightImgView);
    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewSize.width, imgViewSize.height);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, YGap, labLeftSize.width, heightLab);
    //控件3
    CGRect labelMarkRect = CGRectMake(CGRectGetMaxX(labelLeftRect) + padding, CGRectGetMinY(labelLeftRect), markSize.width, heightLab);
    //控件4
    //星星
    CGSize starRateViewSize = CGSizeMake(15*5, 15);
    CGFloat starYGap = (heightLab - starRateViewSize.height)/2.0;
    
    CGRect starViewRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, CGRectGetMaxY(labelLeftRect) + starYGap , starRateViewSize.width, starRateViewSize.height);
    //控件5
    CGRect labelMarkSubRect = CGRectMake(CGRectGetMaxX(starViewRect) + padding, CGRectGetMaxY(labelLeftRect), markSubSize.width+5, kH_LABEL_SMALL);
    //控件6
    CGSize imgViewRightSize = CGSizeMake(25, 25);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.labelLeft.frame = labelLeftRect;

    
    self.labelLeftMark.frame = labelMarkRect;
    self.labelLeftSubMark.frame = labelMarkSubRect;
    
    self.imgViewRight.frame = imgViewRightRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
