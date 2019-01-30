//
//  UITableViewEightyCell.h
//  
//
//  Created by BIN on 2018/5/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNItemsView.h"
 
/**
 类微博(上边文字秒速,底下图片)
 */
@interface UITableViewEightyCell : UITableViewCell

@property (nonatomic, strong) BNItemsView *itemsView;

@end
