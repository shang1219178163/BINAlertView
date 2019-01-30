
//
//  UITableViewThirtySixCell.m
//  
//
//  Created by BIN on 2017/11/9.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThirtySixCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewThirtySixCell ()
 
@end

@implementation UITableViewThirtySixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     icon+文字
     文字2        图像
     文字3
     */
    
    //控件1
    self.imgLabView = [BNImgLabelView labWithImage:nil imageSize:CGSizeMake(15*2, 15)];
    [self.contentView addSubview:self.imgLabView];

    [self.contentView addSubview:self.imgViewRight];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat XYGap = kY_GAP;
    //控件>
    CGSize imgViewRightSize = CGSizeMake(80, 55);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  XYGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
    self.imgViewRight.frame = imgViewRightRect;
    
    
    CGRect iconLabViewRectOne = CGRectMake(XYGap, XYGap, CGRectGetMinX(imgViewRightRect) - XYGap, kH_LABEL);

    CGRect labelLeftRect = CGRectMake(XYGap, CGRectGetMaxY(iconLabViewRectOne), CGRectGetWidth(iconLabViewRectOne), CGRectGetHeight(iconLabViewRectOne));
    CGRect labelLeftSubRect = CGRectMake(XYGap, CGRectGetMaxY(labelLeftRect), CGRectGetWidth(iconLabViewRectOne), CGRectGetHeight(iconLabViewRectOne));
    
    self.imgLabView.frame = iconLabViewRectOne;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
