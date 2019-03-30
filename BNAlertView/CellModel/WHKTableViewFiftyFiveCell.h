//
//  WHKTableViewFiftyFiveCell.h
//  HuiZhuBang
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHKTableViewFiftyFiveCell : UITableViewCell

@property (nonatomic, strong) UILabel * labelLeft;

@property (nonatomic, strong) UISegmentedControl * segmentCtrl;

@property (nonatomic, strong) UIView * lineTop;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
