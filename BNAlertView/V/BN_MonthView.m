//
//  BN_MonthView.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/7/31.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_MonthView.h"

@interface BN_MonthView ()


@end

@implementation BN_MonthView

-(void)dealloc{
    [self.labMonth removeObserver:self forKeyPath:@"text"];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];

        [self addSubview:self.imgView];
        [self addSubview:self.labYear];
        [self addSubview:self.labMonth];

    }
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat kW_ImgView = CGRectGetWidth(self.frame) - kPadding*2;
    self.imgView.frame = CGRectMake((CGRectGetWidth(self.frame) - kW_ImgView/2.0)/2.0, kPadding, kW_ImgView/2.0, kW_ImgView/2.0);
    self.labYear.frame = CGRectMake(kPadding, CGRectGetMaxY(self.imgView.frame) + kPadding, kW_ImgView, kW_ImgView/2.0);
    
    self.labMonth.frame = CGRectMake(kPadding, (CGRectGetHeight(self.frame) - kW_ImgView)/2.0 , kW_ImgView, kW_ImgView);
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        NSString * text = change[NSKeyValueChangeNewKey];
        if (text && [text containsString:@"月"]) {
            NSArray * textTaps = [text componentsSeparatedByString:@"月"];
            NSAttributedString * attString = [self getAttString:text textTaps:textTaps font:@17 tapFont:@36 color:UIColor.whiteColor tapColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
            self.labMonth.attributedText = attString;
        }
    }
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            
            imageView;
        });
    }
    return _imgView;
    
}

-(UILabel *)labYear{
    if (!_labYear) {
        _labYear = ({
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30)];
            lab.font = [UIFont systemFontOfSize:16];
            lab.textColor = UIColor.whiteColor;
            lab.backgroundColor = UIColor.themeColor;
            
            lab.numberOfLines = 0;
            lab.lineBreakMode = NSLineBreakByCharWrapping;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            lab.userInteractionEnabled = YES;
            
            lab;
        });
    }
    return _labYear;
}

-(UILabel *)labMonth{
    if (!_labMonth) {
        _labMonth = ({
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30)];
            lab.font = [UIFont systemFontOfSize:16];
            lab.textColor = UIColor.whiteColor;
            lab.backgroundColor = [UIColor orangeColor];
            
            lab.numberOfLines = 0;
            lab.lineBreakMode = NSLineBreakByCharWrapping;
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.userInteractionEnabled = YES;
            
            lab;
        });
    }
    return _labMonth;
}


@end
