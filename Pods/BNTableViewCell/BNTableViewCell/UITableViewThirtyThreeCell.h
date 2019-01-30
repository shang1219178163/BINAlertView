//
//  UITableViewThirtyThreeCell.h
//  
//
//  Created by BIN on 2017/10/30.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

/**
 //图片1+文字2+icon3+单选框5
 //     文字4
 */
@interface UITableViewThirtyThreeCell : UITableViewCell

@property (nonatomic, assign) CGSize  iconSize;
@property (nonatomic, strong) UIImageView * imgViewIcon;

@end
