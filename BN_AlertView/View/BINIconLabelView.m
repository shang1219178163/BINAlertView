//
//  BINIconLabelView.m
//  WeiHouBao
//
//  Created by hsf on 2017/9/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINIconLabelView.h"

@interface BINIconLabelView ()

@end

@implementation BINIconLabelView

+ (BINIconLabelView *)labWithImage:(id)image{
    
    BINIconLabelView *view = [[self alloc]init];
    if ([image isKindOfClass:[NSString class]]){
        view.imgView.image = [UIImage imageNamed:image];
        
    }else{
        view.imgView.image = image;
        
    }
    return view;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        // Initialization code
        UIImageView *imgView = [[UIImageView alloc]init];
        [self addSubview:imgView];
        
        UILabel * labelTitle = [UIView createLabelRect:CGRectZero text:@"" font:15 tag:kTAG_LABEL type:@0];
        [self addSubview:labelTitle];
        
        //
        self.imgView = imgView;
        self.labelTitle = labelTitle;
        
        self.imgView.layer.borderColor = [UIColor redColor].CGColor;
        self.imgView.layer.borderWidth = 1;
        self.labelTitle.layer.borderColor = [UIColor blueColor].CGColor;
        self.labelTitle.layer.borderWidth = 1;
        
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        self.layer.borderWidth = 1;
        
    }
    return self;

}

-(void)setFrame:(CGRect)frame{
    
    CGFloat imgHeight = CGRectGetHeight(frame)/2.0;
    CGFloat padding = kPadding;
    
    self.imgView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (CGRectGetHeight(frame) - imgHeight)/2.0, imgHeight, imgHeight);
    self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + padding, CGRectGetMinY(frame), CGRectGetWidth(frame) - CGRectGetWidth(self.imgView.frame) - padding, CGRectGetHeight(frame));
}

@end
