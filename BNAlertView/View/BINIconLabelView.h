//
//  BINIconLabelView.h
//  WeiHouBao
//
//  Created by hsf on 2017/9/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BINIconLabelView : UIView

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * labelTitle;


+ (BINIconLabelView *)labWithImage:(id)image;

@end
