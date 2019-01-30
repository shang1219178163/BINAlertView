//
//  UITableHeaderFooterViewTwo.m
//  
//
//  Created by BIN on 2018/5/11.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableHeaderFooterViewTwo.h"

#import "BNGloble.h"
#import "UIButton+Helper.h"

@implementation UITableHeaderFooterViewTwo
 
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    self.contentView.backgroundColor = UIColor.whiteColor;
    //图片+文字+按钮
    
    self.btn.imageView.image = nil;
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.btn];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
        
    CGSize labelLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];

    CGFloat labelH = kH_LABEL;
    CGFloat btnH = 30;

    //文字+文字
    CGFloat YGap = CGRectGetMidY(self.contentView.frame) - labelH/2.0;
    self.imgViewLeft.frame = CGRectMake(kX_GAP, YGap, labelH, labelH);
    self.labelLeft.frame = CGRectMake(CGRectGetMaxX(self.imgViewLeft.frame)+kPadding, YGap, labelLeftSize.width, labelH);

    
    CGSize btnSize = [self.btn btnSizeByHeight:btnH];
    self.btn.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - kX_GAP - btnSize.width, CGRectGetMidY(self.imgViewLeft.frame) - btnH/2.0, btnSize.width, btnSize.height);
}


@end
