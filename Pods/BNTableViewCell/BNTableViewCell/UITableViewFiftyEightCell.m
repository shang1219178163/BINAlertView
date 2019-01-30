//
//  UITableViewFiftyEightCell.m
//  
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewFiftyEightCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewFiftyEightCell ()
 
@end

@implementation UITableViewFiftyEightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字+|+文字+文字
    //控件2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    [self.contentView addSubview:self.labelRight];
    [self.contentView addSubview:self.labelRightSub];
    
    
    [self.contentView addSubview:self.lineVert];

    self.labelLeft.font = self.labelLeftSub.font = self.labelRight.font = self.labelRightSub.font;
    self.labelLeftSub.textAlignment = NSTextAlignmentRight;
    self.labelRightSub.textAlignment = NSTextAlignmentRight;

    self.labelLeftSub.adjustsFontSizeToFitWidth = YES;
    self.labelRightSub.adjustsFontSizeToFitWidth = YES;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字+|+文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize labRigthSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
    
    if (![self.labelLeft.text validObject]) self.labelLeft.hidden = YES;;
    if (![self.labelRight.text validObject]) self.labelRight.hidden = YES;
    
    //控件
    CGFloat XGap = kX_GAP;
    CGFloat YGap = kY_GAP;
    CGFloat padding = 10;
    
    CGFloat lableLeftH = kH_LABEL;
    CGFloat labelSubWidth = CGRectGetWidth(self.contentView.frame)/2.0 - labLeftSize.width - XGap*2 - padding;
    CGFloat labelSubWidthRight = CGRectGetWidth(self.contentView.frame)/2.0 - labRigthSize.width - XGap*2 - padding;

    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    self.labelLeftSub.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+padding, CGRectGetMinY(self.labelLeft.frame), labelSubWidth, lableLeftH);
    
    self.labelRight.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0+kX_GAP, CGRectGetMinY(self.labelLeft.frame), labRigthSize.width, lableLeftH);
    self.labelRightSub.frame = CGRectMake(CGRectGetMaxX(self.labelRight.frame)+padding, CGRectGetMinY(self.labelLeft.frame), labelSubWidthRight, lableLeftH);

    self.lineVert.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0, YGap, 1, CGRectGetHeight(self.contentView.frame) - kY_GAP*2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UIView *)lineVert{
    if (!_lineVert) {
        _lineVert = [UIView createLineRect:CGRectMake(0, 0, kScreenWidth, kH_LINE_VIEW) isDash:NO hidden:NO tag:kTAG_VIEW+11];
        _lineVert.backgroundColor = UIColor.lineColor;

    }
    return _lineVert;
}

-(UILabel *)labelRightSub{
    if (!_labelRightSub) {
        _labelRightSub = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+5 type:@2];
        _labelRightSub.textAlignment = NSTextAlignmentRight;
    }
    return _labelRightSub;
}

@end
