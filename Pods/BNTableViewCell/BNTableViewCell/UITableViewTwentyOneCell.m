//
//  UITableViewTwentyOneCell.m
//  
//
//  Created by BIN on 2017/9/25.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewTwentyOneCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"

#import "UIView+Helper.h"

@interface UITableViewTwentyOneCell ()

@end

@implementation UITableViewTwentyOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1+文字2+BTN3+BTN4
    //------------------------
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    
    //控件3
    [self.contentView addSubview:self.btnOne];
    [self.contentView addSubview:self.btnTwo];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //文字1+文字2+BTN3+BTN4
    //------------------------
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize labLeftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:CGFLOAT_MAX];
    CGSize btnOneSize = [self sizeWithText:self.btnOne.titleLabel.text font:self.btnOne.titleLabel.font width:CGFLOAT_MAX];

    labLeftSize.width += 5;
    
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat lableLeftH = kH_LABEL;
    
    CGRect titleRect = CGRectMake(kX_GAP, (CGRectGetHeight(self.contentView.frame) - lableLeftH)/2.0, labLeftSize.width, lableLeftH);
    CGRect titleSubRect = CGRectMake(CGRectGetMaxX(titleRect) + padding, CGRectGetMinY(titleRect), labLeftSubSize.width, lableLeftH);
    
    btnOneSize = CGSizeMake(btnOneSize.width + kPadding*2, 30);
    CGRect btnOneRect = CGRectMake(CGRectGetMaxX(titleSubRect) + padding, (CGRectGetHeight(self.contentView.frame) - btnOneSize.height)/2.0, btnOneSize.width, btnOneSize.height);
    //控件>
    CGSize btnTwoSize = CGSizeMake(80, 35);
    CGRect btnTwoRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - btnTwoSize.width -  kX_GAP, (CGRectGetHeight(self.contentView.frame) - btnTwoSize.height)/2.0, btnTwoSize.width, btnTwoSize.height);

    self.labelLeft.frame = titleRect;
    self.labelLeftSub.frame = titleSubRect;
    
    self.btnOne.frame = btnOneRect;
    self.btnTwo.frame = btnTwoRect;
    
    
    self.btnOne.layer.masksToBounds = YES;
    self.btnOne.layer.cornerRadius = btnOneSize.height/10;
    
    self.btnTwo.layer.masksToBounds = YES;
    self.btnTwo.layer.cornerRadius = btnTwoSize.height/10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - - layz
-(UIButton *)btnOne{
    if (!_btnOne) {
        _btnOne = [UIView createBtnRect:CGRectZero title:@"" font:16 image:nil tag:kTAG_BTN type:@8];
    }
    return _btnOne;
}

-(UIButton *)btnTwo{
    if (!_btnTwo) {
        _btnTwo = [UIView createBtnRect:CGRectZero title:@"" font:16 image:nil tag:kTAG_BTN+1 type:@7];
    }
    return _btnTwo;
}


@end
