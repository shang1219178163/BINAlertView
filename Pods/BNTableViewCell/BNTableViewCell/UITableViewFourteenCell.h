//
//  UITableViewFourteenCell.h
//  
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

/**
 |+图片+文字+箭头
 |+    文字
 */
@interface UITableViewFourteenCell : UITableViewCell

@property (nonatomic, strong) UIView * verticalLineTop;
@property (nonatomic, strong) UIView * verticalLineBottom;

@end
