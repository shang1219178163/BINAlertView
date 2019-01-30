//
//  ZXLBankCardCell.h
//  YHKLB
//
//  Created by zxl on 2017/12/21.
//  Copyright © 2017年 EM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

 
/**
 银行卡(待完善)
 */
@interface UITableViewBankCardCell : UITableViewCell

@property (nonatomic, strong) UIView *shadowBgView;/**<阴影背景view*/
@property (nonatomic, strong) UIView *cardBgView;/**<背景颜色view*/
@property (nonatomic, strong) UIView *miniLogBgView;/**<小logo的背景图标*/
@property (nonatomic, strong) UIImageView *miniLogo;/**<小图标*/
@property (nonatomic, strong) UILabel *bankNameLabel;/**<银行名字*/
@property (nonatomic, strong) UILabel *marketValueLabel;/**<银行卡号*/
@property (nonatomic, strong) UIImageView *logoNewImageView;/**<最新的NEW标志*/
@property (nonatomic, strong) CAGradientLayer *gradientLayer;/**<渐变代码*/

@end
