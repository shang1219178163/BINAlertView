//
//  UITableViewNineCell.m
//  
//
//  Created by BIN on 2017/8/21.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewNineCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewNineCell ()
 
@end

@implementation UITableViewNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     图片+文字+文字
     
     */
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //图片1+文字2+图片3
    //    +文字4
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat imgViewLeftWH = CGRectGetHeight(self.contentView.frame) - YGap * 2;
    if (CGRectGetHeight(self.contentView.frame) > 55) {
        imgViewLeftWH = CGRectGetHeight(self.contentView.frame) *  0.5;
        YGap = (CGRectGetHeight(self.contentView.frame) - imgViewLeftWH)/2.0;
    }
    CGSize imgViewRightSize = CGSizeMake(25, 25);

    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewLeftWH, imgViewLeftWH);
    //控件3
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, CGRectGetMinY(imgViewLeftRect), CGRectGetMinX(imgViewRightRect) - CGRectGetMaxX(imgViewLeftRect) - padding*2, imgViewLeftWH < 40? 20: imgViewLeftWH/2.0);
    //控件4
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, CGRectGetMaxY(labelLeftRect), CGRectGetWidth(labelLeftRect), CGRectGetHeight(labelLeftRect));

    self.imgViewLeft.frame = imgViewLeftRect;
    self.imgViewRight.frame = imgViewRightRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
