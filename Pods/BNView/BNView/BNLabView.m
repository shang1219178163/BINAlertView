//
//  BNLabView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNLabView.h"

#import "BNGloble.h"
#import "BNCategory.h"

@interface BNLabView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgName;

@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor * titleColor;

@end

@implementation BNLabView

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"frame" context:nil];
    [self.imageView removeObserver:self forKeyPath:@"image" context:nil];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        [self.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self updateFrame];
    
}

-(void)hanleActionTap:(UITapGestureRecognizer *)tap{
    if (self.BlockView) self.BlockView(self);
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        [self updateFrame];

    }
    
    if ([keyPath isEqualToString:@"image"]) {
        self.imageView.hidden = self.imageView.image ? NO : YES;

    }
}

- (void)updateFrame{
    
    if (CGSizeEqualToSize(_imgSize, CGSizeZero)) {
        _imgSize = CGSizeMake(15, CGRectGetHeight(self.frame));
        if (!CGRectEqualToRect(self.imageView.frame, CGRectZero)) _imgSize = self.imageView.frame.size;
        
    }
    
    CGFloat titleHeight = kH_LABEL;
    //图片与文字水平时
    CGFloat titleWidth = CGRectGetWidth(self.frame) - _imgSize.width - _padding*3;
    CGSize titleSize = CGSizeMake(titleWidth, titleHeight);
    if (!_imageView.image) {
        titleSize = CGSizeMake(titleWidth + _imgSize.width, titleHeight);
        _imgSize = CGSizeZero;
    }
    
    //图片文字垂直
    CGFloat titleWidthNew = CGRectGetWidth(self.frame) - _padding*2;
    CGSize titleSizeNew = CGSizeMake(titleWidthNew, titleHeight);
    if (!_imageView.image) {
        titleSizeNew = CGSizeMake(titleWidth, titleHeight + _imgSize.height);
        _imgSize = CGSizeZero;
    }
    
    switch ([self.type integerValue]) {
        case 0://图片在上
        {
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.frame) - _imgSize.width)/2.0, _padding, _imgSize.width, _imgSize.height);
            self.titleLabel.frame = CGRectMake(_padding, CGRectGetMaxY(self.imageView.frame)+_padding, titleSizeNew.width, titleSizeNew.height);
            
        }
            break;
        case 1://图片在左
        {
            self.imageView.frame = CGRectMake(_padding, (CGRectGetHeight(self.frame) - _imgSize.height)/2.0, _imgSize.width, _imgSize.height);
            self.titleLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame)+_padding, (CGRectGetHeight(self.frame) - titleSize.height)/2.0, titleSize.width, titleSize.height);
            
        }
            break;
        case 2://图片在下
        {
            self.titleLabel.frame = CGRectMake(_padding, _padding, titleSizeNew.width, titleSizeNew.height);
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.frame) - _imgSize.width)/2.0, CGRectGetMaxY(self.titleLabel.frame)+_padding, _imgSize.width, _imgSize.height);
            
        }
            break;
        case 3://图片在右
        {
            self.titleLabel.frame = CGRectMake(_padding, (CGRectGetHeight(self.frame) - titleSize.height)/2.0, titleSize.width, titleSize.height);
            self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+_padding, (CGRectGetHeight(self.frame) - _imgSize.height)/2.0, _imgSize.width, _imgSize.height);
            
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - -layz

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel * label = [[UILabel alloc]init];
            label.numberOfLines = 1;
            label.adjustsFontSizeToFitWidth = YES;
            
            label.textAlignment = NSTextAlignmentCenter;
            
            label;
        });
    }
    return _titleLabel;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = ({
            UIImageView * imgView = [[UIImageView alloc]init];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //        imgView.backgroundColor = UIColor.randomColor;
            
            imgView;
        });
    }
    return _imageView;
}

    


@end
