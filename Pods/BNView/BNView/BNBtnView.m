//
//  BNBtnView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/17.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNBtnView.h"

#import "BNGloble.h"
#import "BNCategory.h"

@implementation BNBtnView

-(void)dealloc{
    [self.label removeObserver:self forKeyPath:@"text"];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
        [self addSubview:self.imageView];
        
        [self.label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self.imageView addObserver:self forKeyPath:@"image" options:0 context:nil];

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)hanleActionTap:(UITapGestureRecognizer *)tap{
    if (self.block) self.block(self);
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    CGFloat height = CGRectGetHeight(frame);
    CGFloat width = CGRectGetWidth(frame);
    
    if (_padding == 0.0) _padding = 3.0;
    
    
    CGFloat kH_label = kH_LABEL_SMALL;
    if (CGSizeEqualToSize(CGSizeZero, _imgSize)) {
        if ([_type integerValue] <= 1) {
            _imgSize = CGSizeMake(kH_label, kH_label);
            
        } else {
            _imgSize = CGSizeMake(height - _padding*3 - kH_label, height - _padding*3 - kH_label);
            
        }
        
    }
    //图文水平
    CGFloat kW_label_Hor = CGRectGetWidth(frame) - self.imgSize.width - _padding*3;
    //图文垂直
    CGFloat kW_label_Ver = CGRectGetWidth(frame) - _padding*2;
    
    if (!self.imageView.image) {
        self.label.frame = CGRectMake(_padding, (CGRectGetHeight(frame) - kH_label)/2.0, CGRectGetWidth(self.frame) - _padding*2, kH_label);
        return;
    }
    
    switch ([self.type integerValue]) {
        case 0://图上字下
        {
            self.imageView.frame = CGRectMake((width - _imgSize.width)/2.0, _padding, _imgSize.width, _imgSize.height);
            self.label.frame = CGRectMake(_padding, CGRectGetMaxY(self.imageView.frame) + _padding, kW_label_Ver, kH_label);
            
        }
            break;
        case 1://图左字右
        {
            self.imageView.frame = CGRectMake(_padding, (height - _imgSize.height)/2.0, _imgSize.width, _imgSize.height);
            self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + _padding, (height - kH_label)/2.0, kW_label_Hor, kH_label);
            
        }
            break;        
        case 2://图下字上
        {
            self.label.frame = CGRectMake(_padding, _padding, kW_label_Ver, kH_label);
            self.imageView.frame = CGRectMake((width - _imgSize.width)/2.0, CGRectGetMaxY(self.label.frame) + _padding, _imgSize.width, _imgSize.height);
            
        }
            break;
        case 3://图右字左
        {
            self.label.frame = CGRectMake(_padding, (height - kH_label)/2.0, kW_label_Hor, kH_label);
            self.imageView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + _padding, (height - _imgSize.height)/2.0, _imgSize.width, _imgSize.height);
            
        }
            break;
        default:
        {
            //图上字下
            self.imageView.frame = CGRectMake((width - _imgSize.width)/2.0, _padding, _imgSize.width, _imgSize.height);
            self.label.frame = CGRectMake(_padding, CGRectGetMaxY(self.imageView.frame) + _padding, kW_label_Ver, kH_label);
        }
            break;
    }
}

#pragma mark - -KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        
        CGSize size = [self sizeWithText:self.label.text font:self.label.font width:CGFLOAT_MAX];
        
//        [UIView animateWithDuration:0.5 animations:^{
            //字
            CGRect rect = self.frame;
            rect.size.width += (size.width - CGRectGetWidth(self.label.frame));
            self.frame = rect;
            
            CGRect rectLab = self.label.frame;
            rectLab.size.width = size.width;
            self.label.frame = rectLab;
       
//        }];
        
    }

}

#pragma mark - -layz

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * lab = [[UILabel alloc]init];
            lab.numberOfLines = 1;
            lab.font = [UIFont systemFontOfSize:17];
            lab.textAlignment = NSTextAlignmentCenter;
            lab;
        });
    }
    return _label;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = ({
            UIImageView * imgView = [[UIImageView alloc]init];
            imgView.contentMode = UIViewContentModeCenter;
            imgView.userInteractionEnabled = YES;

            imgView;
        });
    }
    return _imageView;
}


@end
