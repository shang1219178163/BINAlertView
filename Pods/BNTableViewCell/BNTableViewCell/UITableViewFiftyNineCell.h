//
//  UITableViewFiftyNineCell.h
//  
//
//  Created by BIN on 2018/6/22.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNAlertViewOne.h"

/**
 文字+pickerView(原生)
 */
@interface UITableViewFiftyNineCell : UITableViewCell

@property (nonatomic, strong) NSDictionary * dic;
@property (nonatomic, strong) void(^block)(UITableViewFiftyNineCell *view, NSString * string, NSIndexPath * indexPath);

@end
