
//
//  UITableViewFortyFiveCell.m
//  
//
//  Created by BIN on 2017/12/15.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewFortyFiveCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewFortyFiveCell ()
 
@end


@implementation UITableViewFortyFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片1+文字2
    //    文字3
    
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    
    [self.contentView addSubview:self.iConEP];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //图片+文字+文字+图片
    CGFloat padding = kPadding;
    
    //    CGFloat imgViewLeftWH = CGRectGetHeight(self.frame) - YGap * 2;
    CGSize iConSize = CGSizeMake(15, 15);
    if (!CGSizeEqualToSize(self.iConSize, CGSizeZero)) {
        iConSize = self.iConSize;
        
    }
        
    //控件1
    CGRect iConRect = CGRectMake(kX_GAP, CGRectGetMidY(self.contentView.frame) - iConSize.height/2.0, iConSize.width, iConSize.height);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(iConRect) + padding, kY_GAP, kScreenWidth - CGRectGetMaxX(iConRect) - padding - kX_GAP, kH_LABEL_SMALL);
    //控件3
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), CGRectGetWidth(labelLeftRect), kH_LABEL_SMALL);
    
    self.iConEP.frame = iConRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UIImageView *)iConEP{
    if (!_iConEP) {
        _iConEP = [UIView createImgViewRect:CGRectZero image:@"icon_company.png" tag:kTAG_VIEW+2 type:@0];
    }
    return _iConEP;
}


@end
