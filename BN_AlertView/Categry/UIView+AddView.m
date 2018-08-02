//
//  UIView+AddView.m
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIView+AddView.h"
#import <objc/runtime.h>

#import "MacroUtilities.h"

@interface UIView (addView)

@property (nonatomic, strong) NSArray * selectedArr;
@property (nonatomic, assign) NSInteger selectedIndex;


@end

@implementation UIView (AddView)

//#pragma mark - - tapBlock
//- (void)setTapBlock:(void (^)(UIView * view))tapBlock
//{
//    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (void (^)(UIView * view))tapBlock
//{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//- (void)tapActionWithView:(void (^) (UIView * view))tapClick
//{
//    if (self.tapBlock != tapClick) {
//        self.tapBlock = tapClick;
//    }
//}

- (void)addLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView{
    
    if (!isDash) {
        
        if (![inView viewWithTag:tag]) {
            UIView * lineView = [[UIView alloc]initWithFrame:rect];
            //            lineView.backgroundColor = [Utilities colorWithHexString:@"#d2d2d2"];
            lineView.backgroundColor = [UIColor redColor];
            
            [inView addSubview:lineView];
        }else{
            UIView * linView = (UIView *)[inView viewWithTag:tag];
            linView.frame = rect;
        }
        
    }else{
        
        if (![inView viewWithTag:tag]) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            imageView.tag = tag;
            imageView.backgroundColor = [UIColor clearColor];
            [inView addSubview:imageView];
            
            UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
            [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
            
            CGFloat lengths[] = {3,1.5};
            CGContextRef line = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
            
            CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
            CGContextMoveToPoint(line, 0, 0);    //开始画线
            CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
            CGContextStrokePath(line);
            
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
        }else{
            UIImageView * imageView = (UIImageView *)[inView viewWithTag:tag];
            imageView.frame = rect;
            imageView.backgroundColor = [UIColor clearColor];
            
            UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
            [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
            
            CGFloat lengths[] = {3,1.5};
            CGContextRef line = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
            
            CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
            CGContextMoveToPoint(line, 0, 0);    //开始画线
            CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
            CGContextStrokePath(line);
            
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
        }
        
    }
}

-(void)addRightArrowWithSize:(CGRect)arrowRect WithRowHeight:(CGFloat)rowHeight Tag:(NSInteger)tag inView:(UIView *)inView{
    
    if (![inView viewWithTag:tag]) {

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:arrowRect];
        //    imageView.backgroundColor = [UIColor redColor];
        imageView.image = [UIImage imageNamed:@"右指箭头_n.png"];
        imageView.tag = tag;

        [inView addSubview:imageView];
    }else{
        UIImageView * imageView = (UIImageView *)[inView viewWithTag:tag];
        imageView.frame = arrowRect;
        
    }
    
}

+(CALayer *)createLayerWithInView:(UIView *)inView patternType:(NSNumber *)patternType{
    
    CALayer * layer = [CALayer layer];
    switch ([patternType integerValue]) {
        case 0:
        {
            //上边框
            layer.frame = CGRectMake(0, 0, CGRectGetWidth(inView.frame) - kW_LayerBorderWidth, kW_LayerBorderWidth);
            
        }
            break;
        case 1:
        {
            //左边框
            layer.frame = CGRectMake(0, 0, kW_LayerBorderWidth, (CGRectGetHeight(inView.frame) - kW_LayerBorderWidth));
        }
            break;
        case 2:
        {
            //下边框
            layer.frame = CGRectMake(0, (CGRectGetHeight(inView.frame) - kW_LayerBorderWidth), (CGRectGetWidth(inView.frame) - kW_LayerBorderWidth), kW_LayerBorderWidth);
        }
            break;
        case 3:
        {
            //右边框
            layer.frame = CGRectMake(CGRectGetWidth(inView.frame), 0, kW_LayerBorderWidth, CGRectGetHeight(inView.frame));
        }
            break;
        default:
            break;
    }
    layer.backgroundColor = kC_LineColor.CGColor;
    return layer;
}

-(CALayer *)createLayerByPatternType:(NSString *)patternType{
    
    UIView * view = self;
    CALayer * layer = [CALayer layer];
    switch ([patternType integerValue]) {
        case 0:
        {
            //上边框
            layer.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame) - kW_LayerBorderWidth, kW_LayerBorderWidth);
            
        }
            break;
        case 1:
        {
            //左边框
            layer.frame = CGRectMake(0, 0, kW_LayerBorderWidth, (CGRectGetHeight(view.frame) - kW_LayerBorderWidth));
        }
            break;
        case 2:
        {
            //下边框
            layer.frame = CGRectMake(0, (CGRectGetHeight(view.frame) - kW_LayerBorderWidth), (CGRectGetWidth(view.frame) - kW_LayerBorderWidth), kW_LayerBorderWidth);
        }
            break;
        case 3:
        {
            //右边框
            layer.frame = CGRectMake(CGRectGetWidth(view.frame), 0, kW_LayerBorderWidth, CGRectGetHeight(view.frame));
        }
            break;
        default:
            break;
    }
    layer.backgroundColor = kC_LineColor.CGColor;
//    layer.backgroundColor = kC_RedColor.CGColor;

    return layer;
}


-(CALayer *)createLayerType:(NSNumber *)type{
    
    UIView * view = self;
    CALayer * layer = [view createLayerType:type color:kC_LineColor width:kW_LayerBorderWidth paddingScale:0];
    
    return layer;
}

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale{
    UIView * view = self;
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    switch ([type integerValue]) {
        case 0:
        {
            //上边框
            //            layer.frame = CGRectMake(0, 0, (CGRectGetWidth(view.frame) - width), width);
            
            CGFloat paddingX = CGRectGetWidth(view.frame)*paddingScale;
            layer.frame = CGRectMake(paddingX, 0, CGRectGetWidth(view.frame) - width - paddingX*2, width);
            
        }
            break;
        case 1:
        {
            //左边框
            //            layer.frame = CGRectMake(0, 0, width, (CGRectGetHeight(view.frame) - width));
            
            CGFloat paddingY = CGRectGetHeight(view.frame)*paddingScale;
            layer.frame = CGRectMake(0, paddingY, width, CGRectGetHeight(view.frame) - width - paddingY*2);
        }
            break;
        case 2:
        {
            //下边框
            //            layer.frame = CGRectMake(0, CGRectGetHeight(view.frame) - width, (CGRectGetWidth(view.frame) - width), width);
            
            CGFloat padding = CGRectGetWidth(view.frame)*paddingScale;
            layer.frame = CGRectMake(padding, CGRectGetHeight(view.frame) - width, CGRectGetWidth(view.frame) - width - padding*2, width);
            
        }
            break;
        case 3:
        {
            //右边框
            //            layer.frame = CGRectMake((CGRectGetWidth(view.frame) - width), 0, width, CGRectGetHeight(view.frame));
            
            CGFloat paddingY = CGRectGetHeight(view.frame)*paddingScale;
            layer.frame = CGRectMake((CGRectGetWidth(view.frame) - 0), paddingY, width, CGRectGetHeight(view.frame) - paddingY*2);
            
        }
            break;
        default:
            break;
    }
    return layer;
}


#pragma mark - -类方法

+ (UIView *)createViewWithRect:(CGRect)rect tag:(NSInteger)tag{
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:rect];
    backgroundView.tag = tag;

    backgroundView.backgroundColor = kC_BackgroudColor;

    return backgroundView;
}

+ (UIView *)createLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag{
    
    if (!isDash) {
        UIView * lineView = [[UIView alloc]initWithFrame:rect];
        lineView.backgroundColor = kC_LineColor;

        return lineView;
        
    }else{
        
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            imageView.tag = tag;
            imageView.backgroundColor = [UIColor clearColor];
        
            UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
            [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
            
            CGFloat lengths[] = {3,1.5};
            CGContextRef line = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
            
            CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
            CGContextMoveToPoint(line, 0, 0);    //开始画线
            CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
            CGContextStrokePath(line);
            
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

        return imageView;
    }
}

+ (UILabel *)createLabelWithRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType font:(CGFloat)font  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    if ([text isKindOfClass:[NSString class]]) {
        label.text = text;
        label.textColor = textColor;
        if (textColor == nil) {
            label.textColor = [UIColor blackColor];
        }

    }else if ([text isKindOfClass:[NSAttributedString class]]){
        label.attributedText = text;
        
    }
    label.tag = tag;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    
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
    
    
    label.backgroundColor = [UIColor greenColor];
//    label.backgroundColor = [UIColor whiteColor];
    
//    label.layer.borderWidth = 1;
//    label.layer.borderColor = kC_RedColor.CGColor;

    return label;
}
//小标志专用,例如左侧头像上的"企"
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag font:(CGFloat)font backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment{
    
    UILabel * labelTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    labelTip.center = tipCenter;
    
    labelTip.text = text;
    labelTip.textColor = textColor;
    labelTip.textAlignment = NSTextAlignmentCenter;
    
    labelTip.font = [UIFont boldSystemFontOfSize:font];
    labelTip.layer.masksToBounds = YES;
    labelTip.layer.cornerRadius = CGRectGetHeight(labelTip.frame)/2.0;
    labelTip.layer.borderWidth = 1;
    labelTip.layer.borderColor = [UIColor whiteColor].CGColor;
    labelTip.layer.shouldRasterize = YES;
    labelTip.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    labelTip.backgroundColor = backgroudColor;
    //        labelTip.backgroundColor = kC_RedColor;
    
    labelTip.textAlignment = NSTextAlignmentCenter;
    
    return labelTip;
}
//特定用途
+ (UIImageView *)createImageViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.tag = tag;
    
    if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
        
    }
    else if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];

    }
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:aSelector];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
//    tapGesture.cancelsTouchesInView = NO;
//    tapGesture.delaysTouchesEnded = NO;
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGesture];
    
    return imageView;
}
//imageView通用创建方法
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    imageView.tag = tag;
    if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];
        
    }
    else if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
        
    }
    switch ([patternType integerValue]) {
        case 0://默认方形
        {
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor redColor].CGColor;
            
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.layer.shouldRasterize = YES;
            imageView.clipsToBounds = NO;

        }
            break;
        case 1://圆形
        {
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame)/2.0;
            imageView.layer.borderWidth = 0.5;
            imageView.layer.borderColor = kC_LineColor.CGColor;
            imageView.layer.shouldRasterize = YES;
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.clipsToBounds = NO;

        }
            break;
        case 2://带右下角icon
        {
            //小标志
            NSString * text = @"企";
            CGSize textSize = [self sizeWithText:text font:@(KFZ_Fifth) width:kScreen_width];
            CGFloat textWH = textSize.height > textSize.width ? textSize.height :textSize.width;
            textWH += 5;
            CGFloat offsetXY = CGRectGetHeight(rect)/2.0 * sin(45 * M_PI/180.0);
            
            CGPoint tipCenter = CGPointMake(CGRectGetHeight(rect)/2.0 + offsetXY, CGRectGetHeight(rect)/2.0 + offsetXY);
            //
            UILabel * labelTip = [UIView createTipLabelWithSize:CGSizeMake(textWH, textWH) tipCenter:tipCenter text:text textColor:kC_ThemeCOLOR tag:kTAG_LABEL font:KFZ_Fifth backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
            [imageView addSubview:labelTip];
            
        }
            break;
        default:
            break;
    }
    
//    imageView.backgroundColor = [UIColor whiteColor];
//    imageView.backgroundColor = [UIColor redColor];
//    imageView.backgroundColor = kC_BackgroudColor;

    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor blueColor].CGColor;
   
    return imageView;
}
//选择图片使用
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType hasDeleteBtn:(BOOL)hasDeleteBtn
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;

    if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];

    }
    else if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;

    }
    switch ([patternType integerValue]) {
        case 0://默认方形
        {
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor redColor].CGColor;
            
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.layer.shouldRasterize = YES;
            imageView.clipsToBounds = NO;
            
        }
            break;
        case 1://圆形
        {
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame)/2.0;
            imageView.layer.borderWidth = 0.5;
            imageView.layer.borderColor = kC_LineColor.CGColor;
            imageView.layer.shouldRasterize = YES;
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.clipsToBounds = NO;
            
        }
            break;
        default:
            break;
    }
    
    CGSize btnSize = CGSizeMake(25, 25);
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(CGRectGetWidth(rect) - btnSize.width, 0, btnSize.width, btnSize.height);
    [deleteBtn setImage:[UIImage imageNamed:@"img_photoDelete.png"] forState:UIControlStateNormal];
    //    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
    deleteBtn.tag = kTAG_BTN;
    deleteBtn.alpha = 0.6;
    [imageView addSubview:deleteBtn];

    deleteBtn.hidden = !hasDeleteBtn;

    
    //    imageView.backgroundColor = [UIColor whiteColor];
    //    imageView.backgroundColor = [UIColor greenColor];
    //    imageView.backgroundColor = kC_BackgroudColor;
    
    //    imageView.layer.borderWidth = 1;
    //    imageView.layer.borderColor = [UIColor redColor].CGColor;
    
    return imageView;
}

+ (UITextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType
{
    UITextField * textField = [[UITextField alloc]initWithFrame:rect];
    
    textField.text = text;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:font];
    textField.textAlignment = textAlignment;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.keyboardType = keyboardType;
    
    //        textField.returnKeyType = UIReturnKeyDone;
    //        textField.clearButtonMode = UITextFieldViewModeAlways;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
    //        textField.layer.borderWidth = 1;  // 给图层添加一个有色边框
    //        textField.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
    textField.backgroundColor = [UIColor cyanColor];
    textField.backgroundColor = [UIColor whiteColor];
    
    return textField;
    
}

+ (UIButton *)createBtnWithRect:(CGRect)rect title:(NSString *)title font:(CGFloat)font image:(NSString *)image tag:(NSInteger)tag patternType:(NSString *)patternType target:(id)target aSelector:(SEL)aSelector{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTag:tag];
    
    switch ([patternType integerValue]) {
        case 0://白色背景黑色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
            btn.layer.borderColor = kC_LineColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorderWidth;
            
            [btn setTitleColor:kC_TextColor_Title forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];

        }
            break;
        case 1://橘色背景白色字体无圆角
        {
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_N] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_H] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_D] forState:UIControlStateDisabled];

//            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
            break;
        case 2://白色背景灰色字体无边框
        {
            [btn setTitleColor:kC_TextColor_TitleSub forState:UIControlStateNormal];
        }
            break;
        case 3://地图定位按钮一类
        {
            [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
            
        }
            break;
        case 4://橘色背景白色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
//            btn.layer.borderColor = kC_BtnColor_N.CGColor;
//            btn.layer.borderWidth = kW_LayerBorderWidth;

            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_N] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_H] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:kC_BtnColor_D] forState:UIControlStateDisabled];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
            break;
        case 5://橘色背景白色字体无圆角
        {
            [btn setTitleColor:kC_TextColor_Title forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            
        }
            break;
        case 6://白色背景黑色字体无圆角
        {
            btn.layer.borderColor = kC_LineColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorderWidth;
            
            [btn setTitleColor:kC_TextColor_Title forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            
        }
            break;
        case 7://白色背景橘色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
            
            btn.layer.borderColor = kC_BtnColor_N.CGColor;
            btn.layer.borderWidth = kW_LayerBorderWidth;
            
            [btn setTitleColor:kC_BtnColor_N forState:UIControlStateNormal];
            
        }
            break;
        case 8://蓝色背景白色字体颜色圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;

            [btn setBackgroundImage:[UIImage imageWithColor:kC_ThemeCOLOR_Two] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
            break;

        default:
            break;
    }
    
    [btn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
//    btn.layer.borderWidth = 2;
//    btn.layer.borderColor = [UIColor redColor].CGColor;
//    btn.backgroundColor = [UIColor whiteColor];
//    btn.backgroundColor = [UIColor clearColor];
    
    return btn;
}

+ (UIView *)createCustomSegmentWithTitleArr:(NSArray *)titleArr rect:(CGRect)rect tag:(NSInteger)tag selectedIndex:(NSInteger)selectedIndex font:(CGFloat)font isBottom:(BOOL)isBottom{
    
//    self.selectedArr = titleArr;
//    self.selectedIndex = selectedIndex;

    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    backgroudView.tag = tag;
    backgroudView.backgroundColor = [UIColor whiteColor];
    
    CGFloat labWidth = kScreen_width/titleArr.count;
    CGSize lineViewSize = CGSizeMake(labWidth, 1.0);
    
    for (NSInteger i = 0; i < titleArr.count; i++) {
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(labWidth*i, 0, labWidth, CGRectGetHeight(backgroudView.frame)-lineViewSize.height)];
        lab.tag = kTAG_LABEL+i;
        lab.text = titleArr[i];
        [lab setTextColor:[UIColor blackColor]];
        [lab setFont:[UIFont systemFontOfSize:font]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCustomSegmentView:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        
        lab.userInteractionEnabled = YES;
        [lab addGestureRecognizer:tapGesture];
        
        [backgroudView addSubview:lab];
        
        if (selectedIndex == i) {
            [lab setTextColor:[UIColor orangeColor]];
            
        }
    }
    
    CGRect lineRect = CGRectZero;
    CGFloat startX = selectedIndex * lineViewSize.width;
    
    if(!isBottom){
        lineRect = CGRectMake(startX, CGRectGetHeight(backgroudView.frame)-lineViewSize.height, labWidth, lineViewSize.height);
        
    }else{
        lineRect = CGRectMake(startX, 0, labWidth, lineViewSize.height);
        
    }
    
    UIView * lineView = [[UIView alloc]initWithFrame:lineRect];
    lineView.tag = kTAG_VIEW;
    lineView.backgroundColor = [UIColor orangeColor];
    [backgroudView addSubview:lineView];
        

    return backgroudView;

}

- (void)tapCustomSegmentView:(UITapGestureRecognizer *)recognizer{
    
    UILabel * lab = (UILabel *)recognizer.view;
    UIView * backgroudView = lab.superview;
    UIView * lineView = [backgroudView viewWithTag:kTAG_VIEW];
    
    for (UIView * view in backgroudView.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel * lable = (UILabel *)view;
            if (lab.tag != lable.tag) {
                lable.textColor = [UIColor blackColor];
            }else{
                lab.textColor = [UIColor orangeColor];
                
            }
        }
    }
    
    
    NSInteger selectedIndex = lab.tag - kTAG_LABEL;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = lineView.frame;
        frame.origin.x = selectedIndex * (kScreen_width/self.selectedArr.count);
        lineView.frame = frame;
        
    }];
    
    if (self.segmentViewBlock) {
        self.segmentViewBlock(selectedIndex);

    }
}

+ (UIView *)createBtnViewWithRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor patternType:(NSString *)patternType {

    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    
    UIImageView * imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName]];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.userInteractionEnabled = YES;
    
    CGRect labRect = CGRectZero;
    switch ([patternType integerValue]) {
        case 0:
        {
            imgV.frame = CGRectMake(0, 0, CGRectGetWidth(rect), imgHeight);
            labRect = CGRectMake(CGRectGetMinX(imgV.frame), CGRectGetHeight(imgV.frame), CGRectGetWidth(imgV.frame), CGRectGetHeight(rect) - CGRectGetHeight(imgV.frame));
        }
            break;
        case 1:
        {
            imgV.frame = CGRectMake(0, 0, CGRectGetWidth(rect) * 0.5, CGRectGetHeight(rect));
            labRect = CGRectMake(CGRectGetMaxX(imgV.frame), CGRectGetMinY(imgV.frame), CGRectGetWidth(rect) - CGRectGetWidth(imgV.frame), CGRectGetHeight(imgV.frame));
        }
            break;
        case 2:
        {
            imgV.frame = CGRectMake(0, 0, CGRectGetWidth(rect) * 1/3, CGRectGetHeight(rect));
            labRect = CGRectMake(CGRectGetMaxX(imgV.frame), CGRectGetMinY(imgV.frame), CGRectGetWidth(rect) - CGRectGetWidth(imgV.frame), CGRectGetHeight(imgV.frame));
        }
            break;
        case 3://leftMenu 安全保障
        {
            labRect = CGRectMake(0, 35, CGRectGetWidth(rect), kH_LABEL);
            imgV.frame = CGRectMake((CGRectGetWidth(rect) - 35)/2.0, 0, 35, 35);
            
        }
            break;
        case 4://企业
        {
            CGFloat YGap = (CGRectGetHeight(rect) - imgHeight)/2.0;
            CGFloat padding = 0;
            imgV.frame = CGRectMake(YGap, YGap, imgHeight, imgHeight);
            labRect = CGRectMake(CGRectGetMaxX(imgV.frame) + padding, CGRectGetMinY(imgV.frame), CGRectGetWidth(rect) - CGRectGetMaxX(imgV.frame) - padding , imgHeight);
            
        }
            break;
        default:
            break;
    }
    UILabel * lab = [[UILabel alloc]initWithFrame:labRect];
    lab.text = title;
    lab.textColor = titleColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:13];
    [lab setNumberOfLines:1];
    [lab setLineBreakMode:NSLineBreakByTruncatingTail];
    lab.tag = kTAG_LABEL;
    
    lab.adjustsFontSizeToFitWidth = YES;
    //    lab.minimumScaleFactor = 0.5;
    
    //    NSLog(@"imgV.frame %@ labRect  %@",NSStringFromCGRect(imgV.frame),NSStringFromCGRect(labRect));
//    imgV.backgroundColor = [UIColor redColor];
//    lab.backgroundColor = [UIColor yellowColor];
//    backgroudView.backgroundColor = [UIColor greenColor];
    backgroudView.layer.borderColor = [[UIColor blueColor]CGColor];
    backgroudView.layer.borderWidth = 0.5;
    
    [backgroudView addSubview:imgV];
    [backgroudView addSubview:lab];

    return backgroudView;
}

#pragma mark - - otherFuntions
+ (UISegmentedControl *)createSegmentWithRect:(CGRect)rect titles:(NSArray *)titleArr textColor:(UIColor *)textColor backgroudColor:(UIColor *)backgroudColor selectedIndex:(NSInteger)selectedIndex tagert:(id)target aSelector:(SEL)aSelector{
    
    UIColor * defaultColor = [UIColor whiteColor];//点击状态下的背景色
    UIColor * defaultTextColor = [UIColor orangeColor];//点击状态下文字颜色
    defaultTextColor = kC_ThemeCOLOR;//点击状态下文字颜色

    defaultTextColor = textColor;
    defaultColor = backgroudColor;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:titleArr];
    segmentedControl.frame = rect;
    
    segmentedControl.selectedSegmentIndex = selectedIndex;
    segmentedControl.tintColor = defaultColor;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,defaultColor, NSForegroundColorAttributeName,defaultTextColor,NSBackgroundColorAttributeName, nil];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *attributesHighted = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,defaultTextColor, NSForegroundColorAttributeName,defaultColor,NSBackgroundColorAttributeName,nil];
    [segmentedControl setTitleTextAttributes:attributesHighted forState:UIControlStateSelected];
    
    [segmentedControl addTarget:target action:aSelector forControlEvents:UIControlEventValueChanged];

    return segmentedControl;
    
}

+ (UISegmentedControl *)createSegmentCtlWithRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSString *)type{
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc] initWithItems:items];
    segmentCtrl.frame = rect;
    
    segmentCtrl.backgroundColor = [UIColor whiteColor];
    segmentCtrl.tintColor = kC_ThemeCOLOR;
    
    segmentCtrl.selectedSegmentIndex = selectedIndex ? selectedIndex : 0;
    switch ([type integerValue]) {
        case 1:
        {
            
            segmentCtrl.layer.borderWidth = 1;
            segmentCtrl.layer.borderColor = [UIColor whiteColor].CGColor;
            
            NSDictionary * dict = @{
                                    NSForegroundColorAttributeName :   [UIColor blackColor],
                                    NSFontAttributeName            :   [UIFont systemFontOfSize:16],
                                    
                                    };
            
            [segmentCtrl setTitleTextAttributes:dict forState:UIControlStateNormal];
            [segmentCtrl setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            
        }
            break;
        default:
            break;
    }
    
    //    [segmentCtrl addTarget:self action:@selector(handleActionSwitch:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    return segmentCtrl;
}

@end
