//
//  UITableViewThirtyTwoCell.m
//  
//
//  Created by BIN on 2017/10/21.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThirtyTwoCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

@implementation UITableViewThirtyTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
         
    }
    return self;
}

- (void)createControls{
    //图片+文字+图片
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.imgViewRight];
    [self.contentView addSubview:self.labelLeft];
    
    [self.imgViewLeft addCorners:UIRectCornerAllCorners width:1.5 color:UIColor.themeColor];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];

    //图片+文字+图片
    CGFloat YGap = 15;
    CGFloat padding = kPadding;
    
    CGFloat imgViewLeftWH = CGRectGetHeight(self.contentView.frame) - YGap * 2;
//    imgViewLeftWH = 40;

    CGSize arrowSize = CGSizeMake(kH_LABEL, kH_LABEL);
    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewLeftWH, imgViewLeftWH);
    
    imgViewLeftRect = CGRectMake(30, (self.contentView.maxY - imgViewLeftWH)*0.5, imgViewLeftWH, imgViewLeftWH);
    //控件3
    CGRect imgViewRightRect = CGRectMake(self.contentView.maxX - arrowSize.width -  YGap, CGRectGetMidY(self.contentView.frame) - arrowSize.height/2.0, arrowSize.width, arrowSize.height);
    //控件2
    CGRect titleRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + CGRectGetWidth(imgViewLeftRect)*0.5, CGRectGetMidY(imgViewLeftRect) - arrowSize.height*0.5, CGRectGetMinX(imgViewRightRect) - CGRectGetMaxX(imgViewLeftRect) - padding*2, arrowSize.height);
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.imgViewRight.frame = imgViewRightRect;
    self.labelLeft.frame = titleRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz


@end
