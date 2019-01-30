
//
//  UITableViewFourtyNineCell.m
//  
//
//  Created by BIN on 2018/7/10.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewFourtyNineCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@implementation UITableViewFourtyNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    //文字+文字+文字+文字
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLeft];
    [self.contentView addSubview:self.labCenter];
    [self.contentView addSubview:self.labRight];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize labLeftSize = [self sizeWithText:self.labTitle.text font:self.labTitle.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labTitle.attributedText font:self.labTitle.font width:CGFLOAT_MAX];
    }
    CGFloat XGap = kX_GAP*0.5;
    //    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    CGFloat lableLeftH = CGRectGetHeight(self.contentView.bounds) - XGap*2;
    CGFloat textWidth = (CGRectGetWidth(self.contentView.frame) - labLeftSize.width - XGap*2 - padding*3)/3.0;
    
    self.labTitle.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2, labLeftSize.width, lableLeftH);
    self.labLeft.frame = CGRectMake(CGRectGetMaxX(self.labTitle.frame)+padding, CGRectGetMinY(self.labTitle.frame), textWidth, lableLeftH);
    self.labCenter.frame = CGRectMake(CGRectGetMaxX(self.labLeft.frame)+padding, CGRectGetMinY(self.labLeft.frame), textWidth, lableLeftH);
    self.labRight.frame = CGRectMake(CGRectGetMaxX(self.labCenter.frame)+padding, CGRectGetMinY(self.labCenter.frame), textWidth, lableLeftH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [UIView createLabelRect:CGRectZero text:@"" font:15 tag:kTAG_LABEL type:@2];
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}

-(UILabel *)labLeft{
    if (!_labLeft) {
        _labLeft = [UIView createLabelRect:CGRectZero text:@"" font:15 tag:kTAG_LABEL+1 type:@2 ];
        _labLeft.textAlignment = NSTextAlignmentCenter;
    }
    return _labLeft;
}

-(UILabel *)labCenter{
    if (!_labCenter) {
        _labCenter = [UIView createLabelRect:CGRectZero text:@"" font:15 tag:kTAG_LABEL+2 type:@2];
        _labCenter.textAlignment = NSTextAlignmentCenter;
    }
    return _labCenter;
}

-(UILabel *)labRight{
    if (!_labRight) {
        _labRight = [UIView createLabelRect:CGRectZero text:@"" font:15 tag:kTAG_LABEL+2 type:@0];
        _labRight.textAlignment = NSTextAlignmentCenter;
    }
    return _labRight;
}

@end

