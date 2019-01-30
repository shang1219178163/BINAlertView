//
//  UITableViewSixtyFiveCell.m
//  
//
//  Created by BIN on 2018/4/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewSixtyFiveCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewSixtyFiveCell ()

@end 

@implementation UITableViewSixtyFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelRight];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //文字+文字
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    CGFloat padding = kPadding;
    
    CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
    
    //控件1
    CGRect titleSubRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - kX_GAP - labRightSize.width, YGap, labRightSize.width, kH_LABEL);
    //控件2
    CGRect titleRect = CGRectMake(kX_GAP, CGRectGetMinY(titleSubRect), CGRectGetMinX(titleSubRect) - kX_GAP - padding*2, kH_LABEL);
    
    self.labelLeft.frame = titleRect;
    self.labelRight.frame = titleSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz


@end
