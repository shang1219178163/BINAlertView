
//
//  BN_RadioView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_RadioView.h"

#import "BN_Globle.h"

@interface BN_RadioView ()

@property (nonatomic, strong) NSString * imageNomorl;
@property (nonatomic, strong) NSString * imageSelected;

@property (nonatomic, strong) NSDictionary * attDict;

@end

@implementation BN_RadioView

-(instancetype)initWithFrame:(CGRect)frame attDict:(NSDictionary *)attDict isSelected:(BOOL)isSelected{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelected = isSelected;
        _attDict = attDict;
        
        self.imageView.frame = CGRectEqualToRect(frame, CGRectZero) ? CGRectMake(0, 0, 30, 30) : CGRectMake(0, 0, CGRectGetHeight(frame), CGRectGetHeight(frame));
        self.imageView.image = isSelected == YES ? [UIImage imageNamed:attDict[kRadio_imageH]] : [UIImage imageNamed:attDict[kRadio_imageN]];
        
        [self addSubview:self.imageView];
        
        self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + kPadding, 0, CGRectGetWidth(frame) - CGRectGetMaxX(self.imageView.frame) - kPadding, CGRectGetHeight(frame));
        self.label.text = attDict[kRadio_title];
        if (attDict[kRadio_textColorH] && attDict[kRadio_textColorN]) {
            self.label.textColor = isSelected == YES ? attDict[kRadio_textColorH] : attDict[kRadio_textColorN];

        }
        [self addSubview:self.label];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapGesture];
        
//        self.layer.borderColor = UIColor.blueColor.CGColor;
//        self.layer.borderWidth = 1;
        
    }
    return self;
    
}

- (void)tapView:(UITapGestureRecognizer *)tap{
//    DDLog(@"改变前:_%@",@(self.isSelected));
    self.isSelected = !self.isSelected;
//    DDLog(@"改变后:_%@",@(self.isSelected));

    if (self.block) {
        self.block(self, tap.view, self.isSelected);
    }
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    self.imageView.image = isSelected == YES ? [UIImage imageNamed:_attDict[kRadio_imageH]] : [UIImage imageNamed:_attDict[kRadio_imageN]];
    
    if (_attDict[kRadio_textColorH]) {
        if (_attDict[kRadio_textColorN]) {
            self.label.textColor = isSelected == YES ? _attDict[kRadio_textColorH] : _attDict[kRadio_textColorN];
            
        }else{
            self.label.textColor = isSelected == YES ? _attDict[kRadio_textColorH] : UIColor.blackColor;

        }
    }
       
}


-(void)setOnTheMap:(BOOL)onTheMap{
    _onTheMap = onTheMap;
    
    UITapGestureRecognizer * tapGesture = (UITapGestureRecognizer *)[self.gestureRecognizers firstObject];
    //加上这2行,本视图在cell上的时候,cell选择方法也会响应(一般用于地图界面加上东西)
    tapGesture.cancelsTouchesInView = onTheMap == YES ? NO : YES;
    tapGesture.delaysTouchesEnded = onTheMap == YES ? NO : YES;

}

#pragma mark - -layz

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [self createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"2" font:15 backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
        
    }
    return _label;
}

#pragma mark - -funtions

- (UILabel *)createLabelWithRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType font:(CGFloat)fontSize  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    if ([text isKindOfClass:[NSString class]]) {
        label.text = text;
        label.textColor = textColor;
        
    }
    else if ([text isKindOfClass:[NSAttributedString class]]){
        label.attributedText = text;
        
    }
    label.tag = tag;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    
    switch ([patternType integerValue]) {
        case 0://无限折行
        {
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByCharWrapping;
            
        }
            break;
        case 1://abc...
        {
            
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            
        }
            break;
        case 2://一行字体大小自动调节
        {
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumScaleFactor = 0.8;
        }
            break;
        case 3://圆形
        {
            label.textAlignment = NSTextAlignmentCenter;
            
            label.numberOfLines = 1;
            
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = CGRectGetWidth(rect)/2.0;
            
            label.layer.shouldRasterize = YES;
            label.layer.rasterizationScale = UIScreen.mainScreen.scale;
        }
            break;
        case 4://带边框的圆角矩形标签
        {
            label.numberOfLines = 1;
            
            label.layer.borderColor = textColor.CGColor;
            label.layer.borderWidth = 1.0;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 3;
        }
            break;
        default:
            break;
    }
    
    
    if ([text isKindOfClass:[NSString class]] && ![label.text isEqualToString:@""]){
        label.layer.borderColor = UIColor.clearColor.CGColor;
        
    }
    
    if ([text isKindOfClass:[NSAttributedString class]] && ![label.attributedText.string isEqualToString:@""]) {
        label.layer.borderColor = UIColor.clearColor.CGColor;
        
    }
    
    label.backgroundColor = backgroudColor ? backgroudColor : UIColor.whiteColor;

    
    //    label.backgroundColor = UIColor.greenColor;
    //    label.backgroundColor = UIColor.whiteColor;
    
    //    label.layer.borderWidth = kW_LayerBorder;
    //    label.layer.borderColor = UIColor.blueColor.CGColor;
    
    return label;
}

@end
