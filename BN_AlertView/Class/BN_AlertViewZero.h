//
//  BN_AlertViewZero.h
//  BN_AlertView
//
//  Created by hsf on 2018/8/30.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kX_GAP_OF_WINDOW = 30;//弹窗距离屏幕边界距离
//弹窗内容宽度
#define kWidth_customView  (kScreen_width - (kX_GAP_OF_WINDOW + kXY_GAP)*2)

static const CGFloat kH_BTN = 40;//底下按钮高度

@class BN_AlertViewZero;

typedef void (^BlockAlertView)(BN_AlertViewZero * alertView,  NSInteger btnIndex);

@interface BN_AlertViewZero : UIView

/**
 自定义弹窗,本视图最大优点是customView支持任何UIView及其子类
 
 @param title 标题如果不想显示此控件空间置位nil,一般来说空字符@""比较推荐
 @param msg 信息主体,必须customView为nil,同时有msg和customView时,优先显示customView
 @param customView 如果customeView超出BN_AlertViewZero的尺寸则按比例缩小,类似UIViewContentModeScaleAspectFit
 
 @param btnTitles 底部按钮,支持2个以上
 @return 返回BN_AlertViewZero
 
 注意:customView宽度应为 kScreen_width - (kX_GAP_OF_WINDOW + kXY_GAP)*2
 
 */
+ (BN_AlertViewZero *)alertViewWithTitle:(NSString *)title message:(NSString *)msg customView:(UIView *)customView btnTitles:(NSArray *)btnTitles;

/**
 多行输入框
 */
+ (BN_AlertViewZero *)alertViewWithTitle:(NSString *)title items:(NSArray *)items btnTitles:(NSArray *)btnTitles;

@property (nonatomic, strong, readonly) NSMutableArray * textFieldList;

/**
 msg或者customView的最大宽度值(屏幕宽度-60)
 */
@property (nonatomic, assign ,readonly) CGFloat maxWidth;
@property (nonatomic, assign ,readonly) CGFloat maxHeight;

@property (nonatomic, strong) UIColor * lineColor;

@property (nonatomic, copy) BlockAlertView blockAlertView;
- (void)actionWithBlock:(BlockAlertView)blockAlertView;

- (void)show;
- (void)showByCenter:(CGPoint)center;

- (void)dismiss;

@end

@interface ElementModel : UIView

@property (nonatomic, strong) NSAttributedString * title;
//@property (nonatomic, strong) NSAttributedString * titleAttr;

@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * placeHolder;
@property (nonatomic, assign) BOOL  isMust;

@end


