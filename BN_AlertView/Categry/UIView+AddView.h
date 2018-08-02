//
//  UIView+AddView.h
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "BINTextField.h"

typedef void(^SegmentViewBlock)(NSInteger selectIndex);  // SegmentViewBlock不是变量名,而是这种类型的block的别名

@interface UIView (AddView)

@property (nonatomic, copy)SegmentViewBlock segmentViewBlock;

@property (nonatomic,copy) void(^actionWithBlock)(NSInteger);


- (void)addLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView;

- (void)addRightArrowWithSize:(CGRect)arrowRect WithRowHeight:(CGFloat)rowHeight Tag:(NSInteger)tag inView:(UIView *)inView;

//- (void)addTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)font tag:(NSInteger)tag delegate:(id)delagate textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType isEnable:(BOOL)isEnable inView:(UIView *)inView;
//
//- (void)addBtnWithRect:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag patternType:(NSString *)patternType Target:(id)target aSelector:(SEL)aSelector isHidden:(BOOL)isHidden isEnable:(BOOL)isEnable InView:(UIView *)inView;

+(CALayer *)createLayerWithInView:(UIView *)inView patternType:(NSString *)patternType;
-(CALayer *)createLayerByPatternType:(NSString *)patternType;

-(CALayer *)createLayerType:(NSNumber *)type;

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

#pragma mark - - 类方法
+ (UIView *)createViewWithRect:(CGRect)rect tag:(NSInteger)tag;

+ (UIView *)createLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag;

+ (UILabel *)createLabelWithRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType font:(CGFloat)font backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;
//小标志专用,例如左侧头像上的"企"
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag font:(CGFloat)font backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;

+ (UIView *)createViewForTextFieldWithViewRect:(CGRect)viewRect image:(NSString *)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector subViewRect:(CGRect)subViewRect;

//多图片加手势
+ (UIImageView *)createImageViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;
//imageView通用创建方法
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType;
//选择图片使用
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType hasDeleteBtn:(BOOL)hasDeleteBtn;

+ (UITextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType;

+ (UIButton *)createBtnWithRect:(CGRect)rect title:(NSString *)title font:(CGFloat)font image:(NSString *)image tag:(NSInteger)tag patternType:(NSString *)patternType target:(id)target aSelector:(SEL)aSelector;

+ (UIView *)createCustomSegmentWithTitleArr:(NSArray *)titleArr rect:(CGRect)rect tag:(NSInteger)tag selectedIndex:(NSInteger)selectedIndex font:(CGFloat)font isBottom:(BOOL)isBottom;

+ (UIView *)createBtnViewWithRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor patternType:(NSString *)patternType;

+ (UISegmentedControl *)createSegmentWithRect:(CGRect)rect titles:(NSArray *)titleArr textColor:(UIColor *)textColor backgroudColor:(UIColor *)backgroudColor selectedIndex:(NSInteger)selectedIndex tagert:(id)target aSelector:(SEL)aSelector;

+ (UISegmentedControl *)createSegmentCtlWithRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSString *)type;

@end
