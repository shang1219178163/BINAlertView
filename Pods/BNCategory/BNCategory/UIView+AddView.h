//
//  UIView+AddView.h
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddView)

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

/**
 占位视图(.无数据,网络错误)
 */
@property (nonatomic, strong) UIView *holderView;

-(void)holderView:(NSString *)title image:(NSString *)image;

-(void)addLineRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView;

+(UIView *)createLineRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden tag:(NSInteger)tag;

-(CALayer *)createLayerType:(NSNumber *)type;

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

-(UIView *)createViewType:(NSNumber *)type;

-(UIView *)createViewType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

/**
 右指箭头
 */
+ (UIView *)createArrowRect:(CGRect)rect;

#pragma mark - - 类方法

+ (UIView *)createViewRect:(CGRect)rect tag:(NSInteger)tag;

+ (UILabel *)createLabelRect:(CGRect)rect text:(id)text font:(CGFloat)font tag:(NSInteger)tag type:(NSNumber *)type;
//小标志专用,例如左侧头像上的"企"
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag;

//imageView通用创建方法
+ (UIImageView *)createImgViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag type:(NSNumber *)type;

//选择图片使用
+ (UIImageView *)createImgViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag type:(NSNumber *)type hasDeleteBtn:(BOOL)hasDeleteBtn;

+ (UITextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag;

+ (UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title font:(CGFloat)font image:(NSString *)image tag:(NSInteger)tag type:(NSNumber *)type;

+ (UIView *)createBtnViewRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor type:(NSNumber *)type;

/**
 UISegmentedControl通用创建方法
 */
+ (UISegmentedControl *)createSegmentRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSNumber *)type;

/**
 UISlider通用创建方法
 */
+ (UISlider *)createSliderRect:(CGRect)rect value:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;

/**
 UISwitch通用创建方法
 */
+ (UISwitch *)createSwitchRect:(CGRect)rect isOn:(BOOL)isOn;

+ (UITabBarItem *)createTabBarItem:(nullable NSString *)title image:(nullable NSString *)image selectedImage:(nullable NSString *)selectedImage;

+ (UIBarButtonItem *)createBarItem:(NSString *)obj style:(UIBarButtonItemStyle)style;

+ (UIBarButtonItem *)createBarItem:(NSString *)obj style:(UIBarButtonItemStyle)style target:(id)target action:(nullable SEL)action;

@end
