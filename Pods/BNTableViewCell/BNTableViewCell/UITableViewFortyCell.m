
//
//  UITableViewFortyCell.m
//  
//
//  Created by BIN on 2017/11/15.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewFortyCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewFortyCell ()
 
@end

@implementation UITableViewFortyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片1+文字2+文字3+btn
    //    文字4+文字5
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.btn];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    [self.contentView addSubview:self.labelLeftSub];
    [self.contentView addSubview:self.labelLeftSubMark];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize markSize = [self sizeWithText:self.labelLeftMark.text font:self.labelLeftMark.font width:CGFLOAT_MAX];
    CGSize labSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:CGFLOAT_MAX];
    CGSize markSubSize = [self sizeWithText:self.labelLeftSubMark.text font:self.labelLeftSubMark.font width:CGFLOAT_MAX];

    labSubSize = CGSizeMake(labSubSize.width+4, labSubSize.height+4);
    
    CGFloat heightLab = 20;
    CGFloat heightImgView = CGRectGetHeight(self.contentView.frame) - kY_GAP*2;
    //图片+文字+文字
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
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, CGRectGetMaxY(labelLeftRect) + (CGRectGetHeight(labelLeftRect) - labSubSize.height)/2.0, labSubSize.width, labSubSize.height);
    //控件5
    CGRect labelMarkSubRect = CGRectMake(CGRectGetMaxX(labelLeftSubRect) + kPadding, CGRectGetMaxY(labelLeftRect), markSubSize.width, heightLab);
    //控件6
    CGSize btnRSize = CGSizeMake(80, 30);
    CGRect btnRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - btnRSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - btnRSize.height)/2.0, btnRSize.width, btnRSize.height);
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    self.labelLeftMark.frame = labelMarkRect;
    self.labelLeftSubMark.frame = labelMarkSubRect;
    
    self.btn.frame = btnRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
