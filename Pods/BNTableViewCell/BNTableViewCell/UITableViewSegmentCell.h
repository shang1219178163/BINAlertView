//
//  UITableViewSegmentCell.h
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

/**
 分段按钮
 */
@interface UITableViewSegmentCell : UITableViewCell

@property (nonatomic, strong) UISegmentedControl * segmentCtl;
@property (nonatomic, assign) NSTextAlignment ctlAlignment;


@end

