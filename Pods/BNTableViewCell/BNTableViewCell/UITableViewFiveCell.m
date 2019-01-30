
//
//  UITableViewFiveCell.m
//  
//
//  Created by BIN on 2017/8/17.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewFiveCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

@interface UITableViewFiveCell ()
 
@end

@implementation UITableViewFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片+文字+文字(圆角)+图片
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.imgViewRight];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelRight];

    
    
    //圆角
    self.labelRight.textColor = UIColor.whiteColor;
    self.labelRight.backgroundColor = UIColor.redColor;
    self.labelRight.textAlignment = NSTextAlignmentCenter;
    self.labelRight.baselineAdjustment = UIBaselineAdjustmentAlignCenters;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //图片+文字+文字(圆角)+图片
    
    if (self.imgViewLeft.image) {
        if (CGSizeEqualToSize(self.imgViewLeftSize, CGSizeZero)){
            self.imgViewLeftSize = CGSizeMake(self.imgViewLeft.image.size.width/2.0, self.imgViewLeft.image.size.height/2.0);
        }
        
        CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - self.imgViewLeftSize.height)/2.0;
        CGFloat padding = kPadding;
        
        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
        if (labRightSize.width < kH_LABEL) {
            labRightSize  = CGSizeMake(kH_LABEL, labRightSize.height);
        }
        
        CGSize imgViewRightSize = CGSizeMake(25, 25);
        //控件1
        CGRect imgViewLeftRect = CGRectMake(YGap, YGap, self.imgViewLeftSize.width, self.imgViewLeftSize.height);
        
        //控件4
        CGRect imgViewRightRect = CGRectMake(kScreenWidth - imgViewRightSize.width -  kX_GAP, CGRectGetMidY(imgViewLeftRect) - imgViewRightSize.height/2.0, imgViewRightSize.width, imgViewRightSize.height);
        //控件3
        CGRect titleSubRect = CGRectMake(CGRectGetMinX(imgViewRightRect) - padding - labRightSize.width, CGRectGetMinY(imgViewRightRect), labRightSize.width, CGRectGetHeight(imgViewRightRect));
        //控件2
        CGRect titleRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, CGRectGetMinY(imgViewRightRect), CGRectGetMinX(titleSubRect) - CGRectGetMaxX(imgViewLeftRect) - padding*2, CGRectGetHeight(titleSubRect));
        
        self.imgViewLeft.frame = imgViewLeftRect;
        self.imgViewRight.frame = imgViewRightRect;
        self.labelLeft.frame = titleRect;
        self.labelRight.frame = titleSubRect;
    }
    else{
        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
        if (labRightSize.width < kH_LABEL) {
            labRightSize  = CGSizeMake(kH_LABEL, labRightSize.height);
        }
        
        CGSize arrowSize = CGSizeMake(25, 25);
        CGFloat YGap = CGRectGetMidY(self.contentView.frame) - arrowSize.height/2.0;
        CGFloat padding = kPadding;
        
        //控件1
        
        //控件4
        CGRect arrowRect = CGRectMake(kScreenWidth - arrowSize.width -  kX_GAP, CGRectGetMidY(self.contentView.frame) - arrowSize.height/2.0, arrowSize.width, arrowSize.height);
        //控件3
        CGRect titleSubRect = CGRectMake(CGRectGetMinX(arrowRect) - padding - labRightSize.width, CGRectGetMinY(arrowRect), labRightSize.width, CGRectGetHeight(arrowRect));
        //控件2
        CGRect titleRect = CGRectMake(YGap, YGap, CGRectGetMinX(titleSubRect) - padding, CGRectGetHeight(titleSubRect));
        
        self.imgViewRight.frame = arrowRect;
        self.labelLeft.frame = titleRect;
        self.labelRight.frame = titleSubRect;
        
    }
    //圆角
    [self.labelRight addCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
