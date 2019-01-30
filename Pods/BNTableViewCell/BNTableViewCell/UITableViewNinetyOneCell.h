//
//  UITableViewNinetyOneCell.h
//  
//
//  Created by BIN on 2018/6/19.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

/**
 批次号:20141105-1105 输入框
 */
@interface UITableViewNinetyOneCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString * string;

@property (nonatomic, strong) void(^block)(UITableViewNinetyOneCell *view, NSString * strLeft, NSString * strRight);

@end
