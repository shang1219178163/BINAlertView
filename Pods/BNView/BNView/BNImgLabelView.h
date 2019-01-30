//
//  BNImgLabelView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNImgLabelView : UIView

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * labelTitle;

+ (BNImgLabelView *)labWithImage:(id)image imageSize:(CGSize)imageSize;

//+ (BNImgLabelView *)labRect:(CGRect)rect image:(id)image imageSize:(CGSize)imageSize;

@end
