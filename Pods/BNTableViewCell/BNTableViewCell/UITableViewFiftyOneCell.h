//
//  UITableViewFiftyOneCell.h
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNTextField.h"

/**
 文字+textField+textField+textField
 */
@interface UITableViewFiftyOneCell : UITableViewCell

@property (nonatomic, strong) BNTextField * textFieldLeft;
@property (nonatomic, strong) BNTextField * textFieldCenter;
@property (nonatomic, strong) BNTextField * textFieldRight;

@end
