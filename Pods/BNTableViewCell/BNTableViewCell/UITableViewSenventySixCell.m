
//
//  UITableViewSenventySixCell.m
//  
//
//  Created by BIN on 2018/4/27.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewSenventySixCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIView+Helper.h"

@implementation UITableViewSenventySixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     文字1+文字2
          文字3
           btn
     */
    
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    [self.contentView addSubview:self.labelLeftSub];
    
    [self.contentView addSubview:self.imgViewRight];
    
    
    self.labelLeftMark.textAlignment = NSTextAlignmentRight;
    
    self.labelLeftSub.font = [UIFont systemFontOfSize:16];
    self.labelLeftSub.numberOfLines = 0;
    self.labelLeftSub.lineBreakMode = NSLineBreakByCharWrapping;
    self.labelLeftSub.textColor = UIColor.titleSubColor;
  
    self.imgViewRight.image = [UIImage imageNamed:kIMG_arrowUp];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize textSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize contentSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:(kScreenWidth - 2*kX_GAP)];

    //控件1
    CGRect labelLeftRect = CGRectMake(kX_GAP, kY_GAP, textSize.width, kH_LABEL);
    CGRect labelLeftMarkRect = CGRectMake(CGRectGetMaxX(labelLeftRect) + kPadding, kY_GAP, kScreenWidth - CGRectGetMaxX(labelLeftRect) - kPadding - kX_GAP, kH_LABEL);

    CGFloat height = self.contentView.maxY - kY_GAP*2 - kPadding - kH_LABEL;
    //控件2
    CGRect labelLeftSubRect = CGRectMake(kX_GAP, CGRectGetMaxY(labelLeftRect) + kPadding, kScreenWidth - 2*kX_GAP, height);
    
    CGSize btnSize = CGSizeMake(20, 20);
    CGRect btnRect = CGRectMake(CGRectGetMaxX(labelLeftSubRect) - btnSize.width, CGRectGetMaxY(labelLeftSubRect) - btnSize.height, btnSize.width, btnSize.height);

    self.labelLeft.frame = labelLeftRect;
    self.labelLeftMark.frame = labelLeftMarkRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    self.imgViewRight.frame = btnRect;

    //
    self.imgViewRight.hidden = contentSize.height <= kH_Fold ? YES : NO;
    [UIView animateWithDuration:kDurationDrop animations:^{
        self.imgViewRight.transform = self.imgViewRight.selected  ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
        
    }];
}

//- (void)handleActionSender:(UIButton *)sender{

//    sender.selected = !sender.selected;
//    NSString * title = sender.isSelected  ? kBtnSeleted_YES : kBtnSeleted_NO;
//    [self.btn setTitle:title forState:UIControlStateNormal];
//
//    if (self.block) {
//        self.block(self, sender);
//    }
//}

@end
