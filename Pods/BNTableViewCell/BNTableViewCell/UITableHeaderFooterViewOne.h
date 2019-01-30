//
//  WHKHeaderFooterViewOne.h
//  
//
//  Created by BIN on 2018/4/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UITableViewHeaderFooterView+AddView.h"
 
/**
 文字(宽度自适应)+文字+文字
 */
@interface UITableHeaderFooterViewOne : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel * labelOne;
@property (nonatomic, strong) UILabel * labelTwo;
@property (nonatomic, strong) UILabel * labelThree;

@end
