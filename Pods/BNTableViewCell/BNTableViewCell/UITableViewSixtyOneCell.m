
//
//  UITableViewSixtyOneCell.m
//  
//
//  Created by BIN on 2018/3/28.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewSixtyOneCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"

@interface UITableViewSixtyOneCell ()

@end 

@implementation UITableViewSixtyOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     文字
    +文字
     */
    //控件2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if ([self.labelLeft.attributedText validObject]) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }

    //控件
    CGFloat lableLeftH = kH_LABEL;
    CGFloat XGap = kX_GAP;
    CGFloat YGap = CGRectGetMidY(self.contentView.frame) - lableLeftH;
//    CGFloat padding = 10;
    
    //控件
    self.labelLeft.frame = CGRectMake(XGap, YGap, labLeftSize.width, lableLeftH);
    self.labelLeftSub.frame = CGRectMake(XGap, CGRectGetMaxY(self.labelLeft.frame),labLeftSize.width, lableLeftH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz


@end
