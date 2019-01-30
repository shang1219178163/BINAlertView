//
//  UITableViewPickerViewCell.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNListChooseView.h"

@interface UITableViewPickerViewCell : UITableViewCell

@property (nonatomic, strong) BNListChooseView * chooseView;

@end


