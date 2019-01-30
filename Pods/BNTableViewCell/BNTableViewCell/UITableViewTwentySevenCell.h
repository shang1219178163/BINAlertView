//
//  UITableViewTwentySevenCell.h
//  
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNImgLabelView.h"

@interface UITableViewTwentySevenCell : UITableViewCell

@property (nonatomic, strong) UIImageView * imgViewLeft;

@property (nonatomic, strong) UILabel * labelName;
@property (nonatomic, strong) UILabel * labelPrice;
@property (nonatomic, strong) UILabel * labelIntegrityLevel;

@property (nonatomic, strong) UIButton * btnCall;
@property (nonatomic, strong) UIButton * btnConfirm;

@property (nonatomic, strong) BNImgLabelView * imgLabView;

@property (nonatomic, strong) UIView * lineVert;
@property (nonatomic, strong) UIView * lineTop;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
