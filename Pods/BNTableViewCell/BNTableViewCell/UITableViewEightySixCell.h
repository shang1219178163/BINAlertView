//
//  UITableViewEightySixCell.h
//  
//
//  Created by BIN on 2018/5/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNCycleView.h"

/**
 文本循环往复
 */
@interface UITableViewEightySixCell : UITableViewCell

@property (nonatomic, strong) BNCycleView * cycleView;

@end
