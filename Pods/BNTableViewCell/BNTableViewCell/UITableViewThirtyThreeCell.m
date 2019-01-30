//
//  UITableViewThirtyThreeCell.m
//  
//
//  Created by BIN on 2017/10/30.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThirtyThreeCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIControl+Helper.h"

@interface UITableViewThirtyThreeCell ()

@end
 
@implementation UITableViewThirtyThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片1+文字2+icon3+单选框5
    //     文字4
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    
    [self.contentView addSubview:self.imgViewIcon];
    [self.contentView addSubview:self.radioView];
    
    [self.radioView addActionHandler:^(UIControl * _Nonnull obj) {
        UIButton * sender = (UIButton *)obj;
        sender.selected = !sender.selected;
        
    } forControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize labLeftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:CGFLOAT_MAX];
    
    CGFloat YGap = kY_GAP;
    CGFloat heightLab = kH_LABEL;
    CGFloat heightImgView = CGRectGetHeight(self.contentView.frame) - YGap*2;

    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, heightImgView, heightImgView);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, CGRectGetMinY(imgViewLeftRect), labLeftSize.width, heightLab);
    //控件3
    CGSize iconSize = CGSizeMake(28, 15);
    CGRect imgViewIconRect = CGRectMake(CGRectGetMaxX(labelLeftRect) + kPadding, CGRectGetMidY(labelLeftRect) - iconSize.height/2.0, iconSize.width, iconSize.height);
    
    //控件4
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, CGRectGetMaxY(labelLeftRect), labLeftSubSize.width, heightLab);
    
    //控件5
    CGSize imgViewRightSize = CGSizeMake(30, 30);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
 
    self.imgViewLeft.frame = imgViewLeftRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftMark.frame = labelLeftSubRect;
    self.imgViewIcon.frame = imgViewIconRect;
    self.radioView.frame = imgViewRightRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
