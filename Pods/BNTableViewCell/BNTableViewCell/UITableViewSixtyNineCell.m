//
//  UITableViewSixtyNineCell.m
//  
//
//  Created by BIN on 2018/4/10.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewSixtyNineCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewSixtyNineCell ()

@end

@implementation UITableViewSixtyNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字+文字+文字
    [self.contentView addSubview:self.labelOne];
    [self.contentView addSubview:self.labelTwo];
    [self.contentView addSubview:self.labelThree];
    [self.contentView addSubview:self.labelFour];
      
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //文字+文字
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL_SMALL*2)/2.0;
    CGFloat padding = kPadding;
    NSInteger itemCount = 4;
    CGFloat width = (kScreenWidth - (itemCount-1)*padding - kX_GAP*2)/itemCount;
    width = floorf(width);
    self.labelOne.frame     = CGRectMake(kX_GAP, YGap, width, kH_LABEL_SMALL*2);
    self.labelTwo.frame     = CGRectMake(CGRectGetMaxX(self.labelOne.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelThree.frame   = CGRectMake(CGRectGetMaxX(self.labelTwo.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelFour.frame    = CGRectMake(CGRectGetMaxX(self.labelThree.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL type:@0 ];
    }
    return _labelOne;
}

-(UILabel *)labelTwo{
    if (!_labelTwo) {
        _labelTwo = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+1 type:@0 ];
    }
    return _labelTwo;
}

-(UILabel *)labelThree{
    if (!_labelThree) {
        _labelThree = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+2 type:@0 ];
    }
    return _labelThree;
}

-(UILabel *)labelFour{
    if (!_labelFour) {
        _labelFour = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+3 type:@0 ];
    }
    return _labelFour;
}


@end
