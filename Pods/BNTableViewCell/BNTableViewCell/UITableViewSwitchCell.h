//
//  UITableViewSwitchCell.h
//  BNTableViewCell
//
//  Created by Bin Shang on 2018/12/14.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+AddView.h"

#import "BNSwitchView.h"

/**
 cell - 开关
 */
@interface UITableViewSwitchCell : UITableViewCell

@property (nonatomic, strong) BNSwitchView *switchView;

@end


