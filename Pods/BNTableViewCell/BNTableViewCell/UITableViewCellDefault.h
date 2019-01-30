//
//  UITableViewCellDefault.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNCellDefaultView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCellDefault : UITableViewCell

@property (nonatomic, strong) BNCellDefaultView * defaultView;

@end

NS_ASSUME_NONNULL_END
