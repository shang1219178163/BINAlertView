//
//  UITableViewFortyFourCell.m
//  
//
//  Created by BIN on 2017/12/12.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewFortyFourCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

@interface UITableViewFortyFourCell ()
 
@end

@implementation UITableViewFortyFourCell

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
    
        
    [self.contentView addSubview:self.iConEP];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize textSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
    CGSize titleSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    //图片+文字+文字+图片
    CGFloat YGap = kY_GAP/2;
    CGFloat padding = kPadding;
    
    //    CGFloat imgViewLeftWH = CGRectGetHeight(self.frame) - YGap * 2;
    CGSize imgViewLeftSize = CGSizeMake(20, 20);
    if (!CGSizeEqualToSize(self.iConEPSize, CGSizeZero)) {
        imgViewLeftSize = self.iConEPSize;
        
    }
    
    CGFloat labelHeight = kH_LABEL;
    
    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewLeftSize.width, imgViewLeftSize.height);
    
    //控件3
    CGRect labelRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - textSize.width -  YGap, YGap, textSize.width, labelHeight);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, YGap, CGRectGetMinX(labelRightRect) - CGRectGetMaxX(imgViewLeftRect) - padding * 2, labelHeight);
    labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, YGap, titleSize.width, labelHeight);
    
    CGRect iconRect = CGRectMake(CGRectGetMaxX(labelLeftRect), CGRectGetMidY(labelLeftRect) - 15/2.0, 15, 15);
    //控件4
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(imgViewLeftRect) - YGap - padding, labelHeight);
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.iConEP.frame = iconRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelRight.frame = labelRightRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UIImageView *)iConEP{
    if (!_iConEP) {
        _iConEP = [UIView createImgViewRect:CGRectZero image:@"icon_company.png" tag:kTAG_VIEW+1 type:@0];
    }
    return _iConEP;
}


@end
