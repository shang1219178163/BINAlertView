//
//  BINImgLabelView.m
//  WeiHouBao
//
//  Created by hsf on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINImgLabelView.h"

@interface BINImgLabelView ()

@property (nonatomic, assign) CGRect selfFrame;

@end

@implementation BINImgLabelView

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

-(UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [UIView createLabelRect:CGRectZero text:@"" font:15 tag:kTAG_LABEL type:@0];;
    }
    return _labelTitle;
}

+ (BINImgLabelView *)labWithImage:(id)image{
    
    BINImgLabelView *view = [[self alloc]init];
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
        [self addSubview:self.imgView];
        [self addSubview:self.labelTitle];
        
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1;
        
    }
    return self;
}


-(void)setFrame:(CGRect)frame{
    
    self.selfFrame = frame;
    
    CGSize imgViewSize = CGSizeMake(CGRectGetHeight(frame)*2, CGRectGetHeight(frame));
    CGFloat padding = kPadding;
    
    self.imgView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), imgViewSize.width, imgViewSize.height);
    self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + padding, CGRectGetMinY(frame), CGRectGetWidth(frame) - CGRectGetWidth(self.imgView.frame) - padding, CGRectGetHeight(frame));
}

-(void)setImgViewWidth:(CGFloat)imgViewWidth{
    
    CGSize imgViewSize = CGSizeMake(imgViewWidth, CGRectGetHeight(self.selfFrame));
    CGFloat padding = 0;
    
    self.imgView.frame = CGRectMake(CGRectGetMinX(self.selfFrame), CGRectGetMinY(self.selfFrame), imgViewSize.width, imgViewSize.height);
    self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + padding, CGRectGetMinY(self.selfFrame), CGRectGetWidth(self.selfFrame) - CGRectGetWidth(self.imgView.frame) - padding, CGRectGetHeight(self.selfFrame));
    
}


@end
