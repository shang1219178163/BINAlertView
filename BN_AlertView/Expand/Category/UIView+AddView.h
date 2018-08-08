//
//  UIView+AddView.h
//  HuiZhuBang
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmentViewBlock)(NSInteger selectIndex);  // SegmentViewBlock不是变量名,而是这种类型的block的别名

@interface UIView (AddView)

@property (nonatomic, copy)SegmentViewBlock segmentViewBlock;

@property (nonatomic,copy) void(^actionWithBlock)(NSInteger);

/**
 只显示第一行LineView
 */
+ (void)OnlydisplayFirstLineView:(UIView *)lineView indexPath:(NSIndexPath *)indexPath;

- (void)addLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView;

//+ (UIView *)hiddenLineView:(UIView *)lineView  tag:(NSInteger)tag;

+ (UIView *)createLineWithRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden tag:(NSInteger)tag;

/**
 (弃用)
 */
+ (UIView *)createLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag;

-(CALayer *)createLayerType:(NSNumber *)type;

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

/**
 右指箭头
 */
+ (UIView *)createArrowWithRect:(CGRect)rect;

#pragma mark - - 类方法

/**
 UIView通用创建方法
 */
+ (UIView *)createViewWithRect:(CGRect)rect tag:(NSInteger)tag;

/**
 UILabel通用创建方法
 */
+ (UILabel *)createLabelWithRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType font:(CGFloat)fontSize  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;

/**
 UILabel小标志专用,例如左侧头像上的"企"
 */
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag font:(CGFloat)fontSize backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;

/**
 赋值图片方法new

 @param imgView UIImageView对象
 @param image 字符串或UIImage
 @param imageDefault 网络失败后的默认图
 */
+ (void)renderImgView:(UIImageView *)imgView image:(id)image imageDefault:(NSString *)imageDefault;

+ (void)renderImgView:(UIImageView *)imgView image:(id)image;

/**
 网络图片请求方法(威猴专用)
 */
//- (void)renderImageView:(UIImageView *)imageView imageLastPart:(NSString *)imageLastPart;

/**
 UIImageView通用创建方法
 */
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType;

/**
 UIImageView多图片加手势
 */
+ (UIImageView *)createImageViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;

/**
 UIImageView(上传图片)选择图片使用
 */
+ (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType hasDeleteBtn:(BOOL)hasDeleteBtn;

/**
 UITextField通用创建方法
 */
+ (UITextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType tag:(NSInteger)tag;

/**
 UIButton通用创建方法
 */
+ (UIButton *)createBtnWithRect:(CGRect)rect title:(NSString *)title font:(CGFloat)fontSize image:(NSString *)image tag:(NSInteger)tag patternType:(NSString *)patternType target:(id)target aSelector:(SEL)aSelector;

/**
 CustomSegment通用创建方法
 */
+ (UIView *)createCustomSegmentWithTitleArr:(NSArray *)titleArr rect:(CGRect)rect tag:(NSInteger)tag selectedIndex:(NSInteger)selectedIndex font:(CGFloat)fontSize isBottom:(BOOL)isBottom;

/**
 BtnView通用创建方法
 */
+ (UIView *)createBtnViewWithRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor patternType:(NSString *)patternType;

/**
 UISegmentedControl通用创建方法
 */
+ (UISegmentedControl *)createSegmentWithRect:(CGRect)rect titles:(NSArray *)titleArr textColor:(UIColor *)textColor backgroudColor:(UIColor *)backgroudColor selectedIndex:(NSInteger)selectedIndex tagert:(id)target aSelector:(SEL)aSelector;

/**
 UISwitch通用创建方法
 */
+ (UISwitch *)createSwitchWithRect:(CGRect)rect isOn:(BOOL)isOn;

/**
 UISegmentedControl通用创建方法(无边框)
 */
+ (UISegmentedControl *)createSegmentCtlWithRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSString *)type;

@end
