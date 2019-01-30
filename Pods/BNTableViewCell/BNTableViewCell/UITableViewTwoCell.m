
//
//  UITableViewTwoCell.m
//  
//
//  Created by BIN on 2017/8/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewTwoCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

@interface UITableViewTwoCell ()
 
@end

@implementation UITableViewTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片1+文字2+文字3
    //    文字4
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    [self.contentView addSubview:self.labelRight];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //图片1+文字2+文字3
    //    文字4
    CGSize textSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
    CGSize imgViewLeftSize = CGSizeZero;
    CGFloat labelHeight = kH_LABEL_SMALL;

    if (self.imgViewLeft.image){
        CGFloat scale = UIScreen.mainScreen.scale;
        imgViewLeftSize = CGSizeMake(self.imgViewLeft.image.size.width/scale, self.imgViewLeft.image.size.height/scale);
        //控件1
        CGRect imgViewLeftRect = CGRectMake(kX_GAP, (self.contentView.maxY - imgViewLeftSize.height)/2.0, imgViewLeftSize.width, imgViewLeftSize.height);
        //控件3
        CGRect labelRightRect = CGRectMake(self.contentView.maxX - textSize.width - kY_GAP, kY_GAP, textSize.width, labelHeight);
        //控件2
        CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, CGRectGetMinY(labelRightRect), CGRectGetMinX(labelRightRect) - CGRectGetMaxX(imgViewLeftRect) - kPadding*2, labelHeight);
        //控件4
        CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), self.contentView.maxX - CGRectGetMaxX(imgViewLeftRect) - kY_GAP - kPadding, self.contentView.maxY - CGRectGetMaxY(labelLeftRect) - kY_GAP);
        
        self.imgViewLeft.frame = imgViewLeftRect;
        self.labelLeft.frame = labelLeftRect;
        self.labelRight.frame = labelRightRect;
        self.labelLeftSub.frame = labelLeftSubRect;
        
    }
    else{
        //控件3
        CGRect labelRightRect = CGRectMake(self.contentView.maxX - textSize.width - kY_GAP, kY_GAP, textSize.width, labelHeight);
        //控件2
        CGRect labelLeftRect = CGRectMake(kX_GAP, CGRectGetMinY(labelRightRect), CGRectGetMinX(labelRightRect) - kX_GAP - kPadding, labelHeight);
        //控件4
        CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), self.contentView.maxX - kX_GAP*2, self.contentView.maxY - CGRectGetMaxY(labelLeftRect) - kY_GAP);
        
        self.labelLeft.frame = labelLeftRect;
        self.labelRight.frame = labelRightRect;
        self.labelLeftSub.frame = labelLeftSubRect;
        
    }

}


//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//
//
//    CGSize textSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
//
//    //图片+文字+文字+图片
//    CGFloat YGap = kX_GAP;
//    CGFloat padding = kPadding;
//
//    //    CGFloat imgViewLeftWH = CGRectGetHeight(self.frame) - YGap * 2;
//    CGSize imgViewLeftSize = CGSizeMake(20, 20);
//    CGFloat labelHeight = kH_LABEL;
//
//    //控件1
//    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewLeftSize.width, imgViewLeftSize.height);
//
//    //控件3
//    CGRect labelRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - textSize.width - YGap, YGap, textSize.width, labelHeight);
//    //控件2
//    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, CGRectGetMinY(labelRightRect), CGRectGetMinX(labelRightRect) - CGRectGetMaxX(imgViewLeftRect) - padding * 2, labelHeight);
//    //控件4
//    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(imgViewLeftRect) - YGap - padding, labelHeight);
//
//    self.imgViewLeft.frame = imgViewLeftRect;
//    self.labelLeft.frame = labelLeftRect;
//    self.labelRight.frame = labelRightRect;
//    self.labelLeftSub.frame = labelLeftSubRect;
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
