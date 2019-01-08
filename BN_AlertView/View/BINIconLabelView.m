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
        
        UILabel * labelTitle = [self createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL type:@0 font:kFZ_Fifth backgroudColor:nil alignment:NSTextAlignmentLeft];
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

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        CGFloat XYGap = 0;
//        CGFloat padding = 5;
//        CGSize imgViewSize = CGSizeMake(20, 20);
//        
//        if (imgViewSize.height <= CGRectGetHeight(frame)) {
//            XYGap = (CGRectGetHeight(frame) - imgViewSize.height)/2.0;
//        }else{
//            //图片高度不能超过视图高度
//        }
//
//        UIImageView *imgView = [[UIImageView alloc]init];
//        imgView.frame = CGRectMake(XYGap, XYGap, imgViewSize.width,imgViewSize.height);
//
//        [self addSubview:imgView];
//        
//        UILabel * labelTitle = [self createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL type:@2 font:kFZ_Third backgroudColor:nil alignment:NSTextAlignmentLeft];
//        labelTitle.frame = CGRectMake(CGRectGetMaxX(imgView.frame) + padding, CGRectGetMinY(frame), CGRectGetWidth(frame) - CGRectGetMaxX(imgView.frame) - padding, CGRectGetHeight(frame));
//        [self addSubview:labelTitle];
//
//        //
//        self.imgView = imgView;
//        self.labelTitle = labelTitle;
//        
//        self.imgView.layer.borderColor = [UIColor redColor].CGColor;
//        self.imgView.layer.borderWidth = 1;
//        self.labelTitle.layer.borderColor = [UIColor blueColor].CGColor;
//        self.labelTitle.layer.borderWidth = 1;
//        
//        self.layer.borderColor = [UIColor yellowColor].CGColor;
//        self.layer.borderWidth = 1;
//        
//    }
//    return self;
//}

-(void)setFrame:(CGRect)frame{
    
    CGFloat imgHeight = CGRectGetHeight(frame)/2.0;
    CGFloat padding = kPadding;
    
    self.imgView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + (CGRectGetHeight(frame) - imgHeight)/2.0, imgHeight, imgHeight);
    self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + padding, CGRectGetMinY(frame), CGRectGetWidth(frame) - CGRectGetWidth(self.imgView.frame) - padding, CGRectGetHeight(frame));
}

#pragma mark - -otherFuntions
- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag type:(NSString *)patternType font:(CGFloat)font  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    
    [label setText:text];
    [label setTextColor:textColor];
    [label setFont:[UIFont systemFontOfSize:font]];
    [label setTextAlignment:alignment];
    
    switch ([patternType integerValue]) {
        case 0://无限折行
        {
            [label setNumberOfLines:0];
            [label setLineBreakMode:NSLineBreakByCharWrapping];
            
        }
            break;
        case 1://abc...
        {
            
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
        }
            break;
        case 2://一行字体大小自动调节
        {
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumScaleFactor = 0.8;
        }
            break;
        case 3://圆形
        {
            label.textAlignment = NSTextAlignmentCenter;
            
            [label setNumberOfLines:1];
            
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = CGRectGetWidth(rect)/2.0;
            
            label.layer.shouldRasterize = YES;
            label.layer.rasterizationScale = [UIScreen mainScreen].scale;
        }
            break;
        case 4://带边框的圆角矩形标签
        {
            [label setNumberOfLines:1];
            
            label.layer.borderColor = textColor.CGColor;
            label.layer.borderWidth = 1.0;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 2;
        }
            break;
        default:
            break;
    }
    
    [label setTag:tag];
    
    label.backgroundColor = [UIColor greenColor];
    //    label.backgroundColor = UIColor.whiteColor;
    
    //    label.layer.borderWidth = 1;
    //    label.layer.borderColor = kC_RedColor.CGColor;
    
    return label;
}

@end
