//
//  UITableViewThreeCell.m
//  
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThreeCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

@interface UITableViewThreeCell ()

@end

@implementation UITableViewThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片1+文字2+文字3+图片6
    //     文字4+文字5
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.imgViewRight];

    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    [self.contentView addSubview:self.labelLeftSub];
    [self.contentView addSubview:self.labelLeftSubMark];
    
    [self.imgViewLeft addCorners:UIRectCornerAllCorners width:1.5 color:UIColor.themeColor];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize markSize = [self sizeWithText:self.labelLeftMark.text font:self.labelLeftMark.font width:CGFLOAT_MAX];
    CGSize labSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:CGFLOAT_MAX];
    CGSize markSubSize = [self sizeWithText:self.labelLeftSubMark.text font:self.labelLeftSubMark.font width:CGFLOAT_MAX];
    
    
    CGFloat heightLab = 20;
    CGFloat heightImgView = CGRectGetHeight(self.contentView.frame) - kY_GAP*2;
    //图片+文字
    //    文字+文字
    CGSize imgViewSize = CGSizeMake(heightImgView, heightImgView);
    CGFloat YGap = kY_GAP;
    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewSize.width, imgViewSize.height);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, YGap, labLeftSize.width, heightLab);
    //控件3
    CGRect labelMarkRect = CGRectMake(CGRectGetMaxX(labelLeftRect) + kPadding, CGRectGetMinY(labelLeftRect), markSize.width, heightLab);
    //控件4
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), labSubSize.width, heightLab);//手机号11号字体长度78
    //控件5
    CGRect labelMarkSubRect = CGRectMake(CGRectGetMaxX(labelLeftSubRect) + kPadding, CGRectGetMinY(labelLeftSubRect), markSubSize.width, heightLab);
    //控件6
    CGSize arrowSize = CGSizeMake(25, 25);
    CGRect imgViewRightRect = CGRectMake(self.contentView.maxX - arrowSize.width -  YGap, (self.contentView.maxY - arrowSize.height)/2.0, arrowSize.width, arrowSize.height);
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftMark.frame = labelMarkRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    self.labelLeftSubMark.frame = labelMarkSubRect;
    
    self.imgViewRight.frame = imgViewRightRect;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
