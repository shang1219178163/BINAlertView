
//
//  BNRadioView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNRadioView.h"

#import "BNGloble.h"
//#import "NSBundle+Helper.h"

NSString *const kRadio_title = @"kRadio_title";
NSString *const kRadio_textColorH = @"kRadio_textColorH";
NSString *const kRadio_textColorN = @"kRadio_textColorN";
NSString *const kRadio_imageH = @"kRadio_imageH";
NSString *const kRadio_imageN = @"kRadio_imageN";

@interface BNRadioView ()

@property (nonatomic, strong) NSString * imageNomorl;
@property (nonatomic, strong) NSString * imageSelected;

@property (nonatomic, strong) NSDictionary * attDict;
@property (nonatomic, strong) NSArray * imgList;

@end

@implementation BNRadioView

-(instancetype)initWithFrame:(CGRect)frame attDict:(NSDictionary *)attDict isSelected:(BOOL)isSelected{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelected = isSelected;
        _attDict = attDict;
        
        self.imageView.frame = CGRectEqualToRect(frame, CGRectZero) ? CGRectMake(0, 0, 30, 30) : CGRectMake(0, 0, CGRectGetHeight(frame), CGRectGetHeight(frame));
        self.imageView.image = isSelected  ? [UIImage imageNamed:attDict[kRadio_imageH]] : [UIImage imageNamed:attDict[kRadio_imageN]];
        
        [self addSubview:self.imageView];
        
//        NSBundle *resource_bundle = NSBundleFromParams(self.class, @"BNGloble");
//        UIImage * imageH = [UIImage imageNamed:attDict[kRadio_imageH] inBundle:resource_bundle compatibleWithTraitCollection:nil];
//        UIImage * imageN = [UIImage imageNamed:attDict[kRadio_imageN] inBundle:resource_bundle compatibleWithTraitCollection:nil];
//
//        self.imgList = @[imageN,imageH];
//        self.imageView.image = isSelected  ? imageH : imageN;
        
        self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + kPadding, 0, CGRectGetWidth(frame) - CGRectGetMaxX(self.imageView.frame) - kPadding, CGRectGetHeight(frame));
        self.label.text = attDict[kRadio_title];
        if (attDict[kRadio_textColorH] && attDict[kRadio_textColorN]) {
            self.label.textColor = isSelected  ? attDict[kRadio_textColorH] : attDict[kRadio_textColorN];

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
    
    self.imageView.image = isSelected  ? [UIImage imageNamed:_attDict[kRadio_imageH]] : [UIImage imageNamed:_attDict[kRadio_imageN]];

    if (_attDict[kRadio_textColorH]) {
        if (_attDict[kRadio_textColorN]) {
            self.label.textColor = isSelected  ? _attDict[kRadio_textColorH] : _attDict[kRadio_textColorN];
            
        } else {
            self.label.textColor = isSelected  ? _attDict[kRadio_textColorH] : UIColor.blackColor;

        }
    }
       
}


-(void)setOnTheMap:(BOOL)onTheMap{
    _onTheMap = onTheMap;
    
    UITapGestureRecognizer * tapGesture = (UITapGestureRecognizer *)[self.gestureRecognizers firstObject];
    //加上这2行,本视图在cell上的时候,cell选择方法也会响应(一般用于地图界面加上东西)
    tapGesture.cancelsTouchesInView = onTheMap  ? NO : YES;
    tapGesture.delaysTouchesEnded = onTheMap  ? NO : YES;

}

#pragma mark - -layz

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [self createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL type:@2];
        
    }
    return _label;
}

#pragma mark - -funtions

- (UILabel *)createLabelRect:(CGRect)rect text:(id)text font:(CGFloat)font tag:(NSInteger)tag type:(NSNumber *)type
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    if ([text isKindOfClass:[NSString class]]) {
        label.text = text;
        
    }
    else if ([text isKindOfClass:[NSAttributedString class]]){
        label.attributedText = text;
        
    }
    label.tag = tag;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = NSTextAlignmentCenter;
    
    switch (type.integerValue) {
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
            
            label.layer.borderWidth = 1.0;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 3;
        }
            break;
        default:
            break;
    }
    return label;
}

@end
