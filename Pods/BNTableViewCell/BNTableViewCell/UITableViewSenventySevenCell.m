
//
//  UITableViewSenventySevenCell.m
//  
//
//  Created by BIN on 2018/4/28.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewSenventySevenCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@implementation UITableViewSenventySevenCell

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
     +图片选择器
     */
    //控件2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.pictureView];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //
    //控件
    CGFloat lableLeftH = kH_LABEL;
    CGFloat XGap = kX_GAP;
    CGFloat YGap = kY_GAP;
    
    //控件
    self.labelLeft.frame = CGRectMake(XGap, YGap, CGRectGetWidth(self.contentView.frame) - XGap*2, lableLeftH);
    self.pictureView.frame = CGRectMake(XGap, CGRectGetMaxY(self.labelLeft.frame), CGRectGetWidth(self.labelLeft.frame), CGRectGetHeight(self.contentView.frame) - CGRectGetMaxY(self.labelLeft.frame) - YGap);
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BNAddPictureView *)pictureView{
    if (!_pictureView) {
        _pictureView = ({
            CGFloat itemWidth = (CGRectGetWidth(self.frame) - (kRowOfNumber - 1)*kPadding)/kRowOfNumber;
            BNAddPictureView * pictureView = [[BNAddPictureView alloc]initWithFrame:CGRectMake(kX_GAP, kY_GAP, kScreenWidth - kX_GAP*2 , itemWidth)];
            pictureView.tag = kTAG_VIEW_Picture;
            pictureView;
        });
    }
    return _pictureView;
}


@end
