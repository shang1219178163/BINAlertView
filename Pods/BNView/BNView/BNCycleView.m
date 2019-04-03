//
//  BNCycleView.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNCycleView.h"

#import "BNGloble.h"
#import "BNCategory.h"

static NSTimeInterval kDurationCycle = 20;

@interface BNCycleView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;

@end

@implementation BNCycleView

-(void)dealloc{
    [NSTimer stopTimer:_timer];
    [self.label removeObserver:self forKeyPath:@"text"];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //数据源
        _list = @[
                  @"111111",@"2222222",@"333333",
                  
                  ];
        _index = 0;//从第一条开始显示
        
        [self addSubview:self.label];
        [self addSubview:self.imgView];

        [self.label addObserver:self forKeyPath:@"text" options:0 context:nil];
        
    }
    return self;
}

#pragma mark - -KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"text"]) {
        CGSize size = [self sizeWithText:self.label.text font:self.label.font width:CGFLOAT_MAX];
    
        CGRect rectLab = self.label.frame;
        rectLab.size.width = size.width;
        self.label.frame = rectLab;

    }
}

- (void)start{
    if (self.list.count == 0) {
        return;
    }
    
    [self handleActionTimer];
    
    [NSTimer stopTimer:_timer];
    
    _timer = [NSTimer scheduledTimer:kDurationCycle block:^(NSTimer *timer) {
        [self handleActionTimer];

    } repeats:YES];
    
}

- (void)handleActionTimer{
    
    _index = _index >= _list.count ? 0 : _index;
    _label.text = _list[_index];
    _index++;
    
    CGRect rect = _label.frame;
    rect.origin.x = CGRectGetWidth(self.frame);
    _label.frame = rect;
    
    
//    [UIView animateWithDuration:kDurationCycle animations:^{
//        CGRect rect = _label.frame;
//        
//        rect = _label.frame;
//        rect.origin.x = CGRectGetMaxX(_imgView.frame) - CGRectGetWidth(_label.frame);
//        _label.frame = rect;
//
//    }];
        
    [UIView beginAnimations:@"UIViewAnimationCurveLinear" context:NULL];
    [UIView setAnimationDuration:kDurationCycle];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:0];

    rect = _label.frame;
    rect.origin.x = CGRectGetMaxX(_imgView.frame) - CGRectGetWidth(_label.frame);
    _label.frame = rect;
    [UIView commitAnimations];
    
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
            imgView.userInteractionEnabled = YES;
            imgView.backgroundColor = UIColor.whiteColor;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.image = [UIImage imageNamed:@"img_notice"];
            
            imgView;
        });
    }
    return _imgView;
}

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) - CGRectGetWidth(self.imgView.frame), CGRectGetHeight(self.frame))];
            label.font = [UIFont systemFontOfSize:16];
            label.numberOfLines = 1;
            label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            
            label;
        });
    }
    return _label;
    
}

@end
