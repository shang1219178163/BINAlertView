//
//  UITableViewSenventyTwoCell.h
//  
//
//  Created by BIN on 2018/4/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNLabView.h"

/**
 文字(icon)+文字(icon)+文字(icon)+文字(icon)
 */
@interface UITableViewSenventyTwoCell : UITableViewCell

@property (nonatomic, strong) BNLabView * labViewOne;
@property (nonatomic, strong) BNLabView * labViewTwo;
@property (nonatomic, strong) BNLabView * labViewThree;
@property (nonatomic, strong) BNLabView * labViewFour;


@end
