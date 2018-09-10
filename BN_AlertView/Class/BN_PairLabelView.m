//
//  BN_PairLabelView.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/8/1.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_PairLabelView.h"

@implementation BN_PairLabelView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labOne];
        [self addSubview:self.labTwo];
        
        self.labOne.backgroundColor = UIColor.clearColor;
        self.labTwo.backgroundColor = UIColor.clearColor;
        
        //        self.backgroundColor = kC_BackgroudColor;
        
    }
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if ([self.type integerValue] == 1) {
        CGSize size = [self sizeWithText:self.labOne.text font:self.labOne.font width:CGRectGetWidth(self.frame)];
        
        self.labOne.frame = CGRectMake(0, 0, size.width, CGRectGetHeight(self.frame));
        self.labTwo.frame = CGRectMake(CGRectGetMaxX(self.labOne.frame) + kPadding, 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.labOne.frame) - kPadding, CGRectGetHeight(self.frame));
        
        self.labTwo.textAlignment = NSTextAlignmentCenter;
        
    }
    else{
        if (CGRectGetHeight(self.frame) >= 40) {
            self.labOne.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 20);
            self.labTwo.frame = CGRectMake(0, CGRectGetMaxY(self.labOne.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(self.labOne.frame));
            
        }else{
            self.labOne.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2.0);
            self.labTwo.frame = CGRectMake(0, CGRectGetMaxY(self.labOne.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2.0);
            
        }
        self.labOne.numberOfLines = 1;
        self.labTwo.numberOfLines = 1;
        
        self.labOne.textAlignment = NSTextAlignmentCenter;
        self.labTwo.textAlignment = NSTextAlignmentCenter;
        
        self.labOne.adjustsFontSizeToFitWidth = YES;
        self.labTwo.adjustsFontSizeToFitWidth = YES;
    }
    
}

#pragma mark - -layz

-(UILabel *)labOne{
    if (!_labOne) {
        _labOne = ({
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectZero];
            lab.font = [UIFont systemFontOfSize:16];
            //            lab.textColor = [UIColor whiteColor];
            //            lab.backgroundColor = kC_ThemeCOLOR;
            
            lab.numberOfLines = 0;
            lab.lineBreakMode = NSLineBreakByCharWrapping;
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.userInteractionEnabled = YES;
            
            lab;
        });
    }
    return _labOne;
}

-(UILabel *)labTwo{
    if (!_labTwo) {
        _labTwo = ({
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectZero];
            lab.font = [UIFont systemFontOfSize:16];
            //            lab.textColor = [UIColor whiteColor];
            //            lab.backgroundColor = [UIColor orangeColor];
            
            lab.numberOfLines = 0;
            lab.lineBreakMode = NSLineBreakByCharWrapping;
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.userInteractionEnabled = YES;
            
            lab;
        });
    }
    return _labTwo;
}

@end
