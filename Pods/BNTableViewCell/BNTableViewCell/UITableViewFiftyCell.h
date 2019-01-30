//
//  UITableViewFiftyCell.h
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "PPNumberButton.h"

/**
 文字+numBtn+文字+numBtn
 */
@interface UITableViewFiftyCell : UITableViewCell

@property (nonatomic, strong) PPNumberButton * numberBtnLeft;
@property (nonatomic, strong) PPNumberButton * numberBtnRight;

@end
