//
//  BNImgLabelView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BNImgLabelView.h"

#import "BNGloble.h"

@interface BNImgLabelView ()

@property (nonatomic, assign) CGRect selfFrame;
@property (nonatomic, assign) CGSize imageSize;

@end

@implementation BNImgLabelView

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

-(UILabel *)labelTitle{
    
    if (!_labelTitle) {
        _labelTitle = [self createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL type:@0 font:kFZ_Third backgroudColor:nil alignment:NSTextAlignmentLeft];;
    }
    return _labelTitle;
}

+ (BNImgLabelView *)labWithImage:(id)image imageSize:(CGSize)imageSize
{
    BNImgLabelView *view = [[self alloc]init];
    if ([image isKindOfClass:[NSString class]]){
        view.imgView.image = [UIImage imageNamed:image];
        
    } else {
        view.imgView.image = image;
        
    }
    view.imageSize = imageSize;//self.imageSize
    return view;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        // Initialization code
        [self addSubview:self.imgView];
        [self addSubview:self.labelTitle];

    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    
    self.selfFrame = frame;
    CGSize imgViewSize = self.imageSize;
    if (CGSizeEqualToSize(self.imageSize,CGSizeZero)) {
        imgViewSize = CGSizeMake(CGRectGetHeight(frame), CGRectGetHeight(frame));
    }
    
    CGFloat padding = kPadding;
    CGFloat paddingImgView = (CGRectGetHeight(frame) - imgViewSize.height)/2.0;

    
    CGRect imgViewRect = CGRectZero;
    CGRect lalRect = CGRectZero;
    if (CGRectGetHeight(frame) == imgViewSize.height) {
        //paddingImgView = 0
        imgViewRect = CGRectMake(CGRectGetMinX(frame) + paddingImgView, CGRectGetMinY(frame) + paddingImgView, imgViewSize.width, imgViewSize.height);
        lalRect = CGRectMake(CGRectGetMaxX(imgViewRect) + paddingImgView + padding, CGRectGetMinY(frame), CGRectGetWidth(frame) - CGRectGetMaxX(imgViewRect) - paddingImgView - padding, CGRectGetHeight(frame));

    } else {
        if (imgViewSize.height <= imgViewSize.width) {
            imgViewRect = CGRectMake(CGRectGetMinX(frame) + paddingImgView, CGRectGetMinY(frame) + paddingImgView, imgViewSize.width, imgViewSize.height);
            lalRect = CGRectMake(CGRectGetMaxX(imgViewRect) + paddingImgView, CGRectGetMinY(frame), CGRectGetWidth(frame) - CGRectGetWidth(imgViewRect) - padding - paddingImgView, CGRectGetHeight(frame));
        }
        else{
            paddingImgView = (CGRectGetHeight(frame) - imgViewSize.width)/2.0;
            
            imgViewRect = CGRectMake(CGRectGetMinX(frame) + paddingImgView, CGRectGetMidY(frame) - imgViewSize.height/2.0, imgViewSize.width, imgViewSize.height);
            lalRect = CGRectMake(CGRectGetMaxX(imgViewRect) + paddingImgView, CGRectGetMinY(frame), CGRectGetWidth(frame) - CGRectGetWidth(imgViewRect) - padding - paddingImgView, CGRectGetHeight(frame));
        }
    }
    
    self.imgView.frame = imgViewRect;
    self.labelTitle.frame = lalRect;
    
}

-(CGFloat)getMaxWithCGSzie:(CGSize)size{
    if (size.width >= size.height) {
        return size.width;
    }
    return size.height;
}

-(void)setImgViewWidth:(CGFloat)imgViewWidth{
    
    CGSize imgViewSize = CGSizeMake(imgViewWidth, CGRectGetHeight(self.selfFrame));
    CGFloat padding = 0;
    
    self.imgView.frame = CGRectMake(CGRectGetMinX(self.selfFrame), CGRectGetMinY(self.selfFrame), imgViewSize.width, imgViewSize.height);
    self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + padding, CGRectGetMinY(self.selfFrame), CGRectGetWidth(self.selfFrame) - CGRectGetWidth(self.imgView.frame) - padding, CGRectGetHeight(self.selfFrame));
    
}

#pragma mark - -otherFuntions
- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag type:(NSNumber *)type font:(CGFloat)fontSize  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    [label setText:text];
    [label setTextColor:textColor];
    [label setFont:[UIFont systemFontOfSize:fontSize]];
    [label setTextAlignment:alignment];
    label.userInteractionEnabled = YES;
    switch (type.integerValue) {
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
            label.minimumScaleFactor = 0.6;
        }
            break;
        case 3://圆形
        {
            label.textAlignment = NSTextAlignmentCenter;
            
            [label setNumberOfLines:1];
            
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = CGRectGetWidth(rect)/2.0;
            
            label.layer.shouldRasterize = YES;
            label.layer.rasterizationScale = UIScreen.mainScreen.scale;
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
    
    
//    label.backgroundColor = UIColor.greenColor;
//    label.backgroundColor = UIColor.whiteColor;

//    label.layer.borderWidth = 1;
//    label.layer.borderColor = kC_RedColor.CGColor;
    
    return label;
}


@end
