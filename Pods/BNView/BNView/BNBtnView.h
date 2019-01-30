//
//  BNBtnView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/17.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//
/**
 图片与文字
 type @0,@1,@2,@3 代表图位置上左下右
 adjustsSizeToFitText = yes; 视图随标题长度调整宽度
 */


#import <UIKit/UIKit.h>

@interface BNBtnView : UIView

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, assign) BOOL adjustsSizeToFitText;

@property (nonatomic, copy) void(^block)(BNBtnView *view);

-(instancetype)initWithFrame:(CGRect)frame;

@end
