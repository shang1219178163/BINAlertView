//
//  UIView+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BINTextField.h"
#import "BINTextView.h"

@interface UIView (Helper)
//给view关联点击事件
- (void)tapViewWithBlock:(void (^)(void))block;

/**
 给view关联点击事件(支持UIView和UIButton可继续扩展其他支持)
 @param handler 返回响应对象
 */
- (void)addActionHandler:(void(^)(id obj, id item, NSInteger idx))handler;

// 获取所有子视图
+ (void)getSub:(UIView *)view andLevel:(NSInteger)level;

//给所有自视图加框
- (void)getViewLayer;

- (void)getLayerAllCorners:(UIColor *)borderColor;

+ (BINTextField *)createBINTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)font textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType;
//搜索框
+ (BINTextField *)createBINTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)font textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType leftView:(UIView *)leftView leftPadding:(CGFloat)leftPadding rightView:(UIView *)rightView rightPadding:(CGFloat)rightPadding;

//带提示的textView
+ (BINTextView *)createTextViewWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment keyType:(UIKeyboardType)keyboardType;

/**
 展示性质的textView,不提供编辑
 */
+ (UITextView *)createTextShowWithRect:(CGRect)rect text:(id)text font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment;
//富文本
+ (UILabel *)createRichLabWithRect:(CGRect)rect text:(NSString *)text textTaps:(NSArray *)textTaps;
//图片+文字
+ (UIView *)getImgLabViewRect:(CGRect)rect image:(id)image text:(id)text imgViewSize:(CGSize)imgViewSize;

+ (UIView *)createViewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler;


/**
 itemview集合

 @param type 子视图是UIBUtton?UIImageView?UILable?
 @return view
 */
+ (UIView *)createViewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type;

- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;

- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;

//向屏幕倾斜
+ (void)transformStateEventWithView:(UIView *)view;

+ (void)DisplayLastLineViewWithInset:(UIEdgeInsets)separatorInset cell:(UITableViewCell *)cell;
- (void)reloadItems:(NSArray *)items itemWidth:(CGFloat)itemWidth;

//- (void)tapActionWithView:(void (^) (UIView * view))tapClick;
//- (void)tapView:(UIView* )view tapClick:(void (^) (UIView *View))tapClick;




@end
