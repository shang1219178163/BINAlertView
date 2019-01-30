
//
//  UITableViewFourteenCell.m
//  
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewFourteenCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"

@interface UITableViewFourteenCell ()

@end

@implementation UITableViewFourteenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     |+图片+文字+箭头
     |+    文字
     */
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.imgViewRight];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    [self.contentView addSubview:self.verticalLineTop];
    [self.contentView addSubview:self.verticalLineBottom];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //图片+文字+图片
    //   +文字
    CGFloat YGap = kY_GAP/2;
    CGFloat padding = kPadding;
    
    //    CGFloat imgViewLeftWH = CGRectGetHeight(self.frame) - YGap * 2;
    CGSize imgViewLeftSize = CGSizeMake(20, 20);
    CGFloat labelHeight = kH_LABEL;
    CGSize imgViewRightSize = CGSizeMake(25, 25);
    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewLeftSize.width, imgViewLeftSize.height);
    //控件3
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, YGap, CGRectGetMinX(imgViewRightRect) - CGRectGetMaxX(imgViewLeftRect) - padding*2, labelHeight);
    //控件4
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), CGRectGetWidth(labelLeftRect), labelHeight);
    
    CGRect verticalLineTopRect = CGRectMake(CGRectGetMidX(imgViewLeftRect), 0, kH_LINE_VIEW, CGRectGetMidY(imgViewLeftRect));
    CGRect verticalLineBottomRect = CGRectMake(CGRectGetMidX(imgViewLeftRect), CGRectGetMidY(imgViewLeftRect), kH_LINE_VIEW, CGRectGetHeight(self.contentView.frame) - CGRectGetMidX(imgViewLeftRect));

    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.imgViewRight.frame = imgViewRightRect;
    
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
    self.verticalLineTop.frame = verticalLineTopRect;
    self.verticalLineBottom.frame = verticalLineBottomRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

