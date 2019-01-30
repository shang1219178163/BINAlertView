//
//  UITableViewFiftyTwoCell.m
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewFiftyTwoCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewFiftyTwoCell ()

  
@end

@implementation UITableViewFiftyTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //|+文字+箭头
    [self.contentView addSubview:self.labelLeftPrefix];
    [self.contentView addSubview:self.labelLeft];
//    [self.contentView addSubview:self.labelLeftSub];

    [self.contentView addSubview:self.imgViewRight];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if ([self.labelLeft.attributedText validObject]) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    
    CGFloat XGap = kX_GAP;
//    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    CGFloat lableLeftH = kH_LABEL;
    
    CGSize imgViewRightSize = CGSizeMake(25, 25);
    self.imgViewRight.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  XGap, CGRectGetMidY(self.contentView.frame) - imgViewRightSize.height/2.0, imgViewRightSize.width, imgViewRightSize.height);
    
    self.labelLeftPrefix.frame = CGRectMake(padding, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, kW_LINE_Vert, lableLeftH);
    self.labelLeft.frame = CGRectMake(CGRectGetMaxX(self.labelLeftPrefix.frame) + XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labelLeftPrefix{
    if (!_labelLeftPrefix) {
        _labelLeftPrefix = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+5 type:@2];
    }
    return _labelLeftPrefix;
}


@end
