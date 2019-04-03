//
//  BNTurnView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNTurnView.h"

#import "BNGloble.h"
#import "BNCategory.h"

@interface BNTurnView ()

@property (nonatomic,strong) UILabel *labelOne;
@property (nonatomic,strong) UILabel *labelTwo;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) BOOL isShowOne;

@end

@implementation BNTurnView

-(void)dealloc{
    [NSTimer stopTimer:_timer];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        [self addSubview:self.imgView];
        
        [self addSubview:self.labelOne];
        [self addSubview:self.labelTwo];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat padding = 8.0;
    
    if (!self.imgView.image) {
        self.imgView.frame = CGRectZero;

    }
    self.labelOne.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + padding, 0, CGRectGetWidth(self.frame) - (CGRectGetMaxX(self.imgView.frame) + padding) - padding, CGRectGetHeight(self.frame));

    self.labelTwo.frame = CGRectMake(CGRectGetMinX(self.labelOne.frame), CGRectGetMaxY(self.labelOne.frame), CGRectGetWidth(self.labelOne.frame), CGRectGetHeight(self.labelTwo.frame));
}

- (void)setList:(NSArray *)turnArray {
    _list = turnArray;
    _index = 1;
    
    if (_list.count == 0) {
        return;
    }
    if (_list.count == 1) {
        self.labelOne.text = _list[0];
    } else {
        self.labelOne.text = _list[0];
        self.labelTwo.text = _list[1];
        
//        [NSTimer stopTimer:_timer];
//        _timer = [NSTimer scheduledTimer:2 block:^(NSTimer *timer) {
//            [self updateLabs];
//
//        } repeats:YES];
        
    }
}

-(void)start{
    NSAssert(_list.count > 0, @"数组不能为空");
    if (_list.count == 1) {
        self.labelOne.text = _list[0];
        return;
    }
    
    _interval = _interval > 0.0 ? _interval : 2.0;
    
    [NSTimer stopTimer:_timer];
    _timer = [NSTimer scheduledTimer:_interval block:^(NSTimer *timer) {
        [self updateLabs];
        
    } repeats:YES];
    
}

- (void)updateLabs{
    //    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    _index++;
    if (_index > _list.count - 1) {
        _index = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (!_isShowOne) {//2lab向上平移
            CGRect rectOne = _labelOne.frame;
            rectOne.origin.y -= height;
            _labelOne.frame = rectOne;
            
            CGRect rectTwo = _labelTwo.frame;
            rectTwo.origin.y -= height;
            _labelTwo.frame = rectTwo;
            
        }
        if (_isShowOne) {
            CGRect rectOne = _labelOne.frame;
            rectOne.origin.y = 0;
            _labelOne.frame = rectOne;
            
            CGRect rectTwo = _labelTwo.frame;
            rectTwo.origin.y = -height;
            _labelTwo.frame = rectTwo;
            
        }
    } completion:^(BOOL finished) {
        _isShowOne = !_isShowOne;
        if (_labelOne.frame.origin.y == -height) {
            _labelOne.text = _list[_index];
            
            CGRect rectOne = _labelOne.frame;
            rectOne.origin.y = height;
            _labelOne.frame = rectOne;
            
        }
        if (_labelTwo.frame.origin.y == -height) {
            _labelTwo.text = _list[_index];
            
            CGRect rectTwo = _labelTwo.frame;
            rectTwo.origin.y = height;
            _labelTwo.frame = rectTwo;
        }
    }];
}

#pragma mark - -layz

-(UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = ({
            UILabel * label = [[UILabel alloc]initWithFrame:self.bounds];
            label.font = [UIFont systemFontOfSize:16];
            label.numberOfLines = 2;
            label.tag = kTAG_LABEL;
            
//            label.backgroundColor = UIColor.greenColor;

            label;
        });
    }
    return _labelOne;

}

-(UILabel *)labelTwo{
    if (!_labelTwo) {
        _labelTwo = ({
            UILabel * label = [[UILabel alloc]initWithFrame:self.bounds];
            label.font = [UIFont systemFontOfSize:16];
            label.numberOfLines = 2;
            label.tag = kTAG_LABEL + 1;

//            label.backgroundColor = UIColor.yellowColor;

            label;
        });
    }
    return _labelTwo;
    
}

-(UIImageView *)imgView{
    
    if (!_imgView) {
        _imgView = ({
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.image = [UIImage imageNamed:@"img_notice"];

            imgView;
            
        });
    }
    return _imgView;
}

@end
