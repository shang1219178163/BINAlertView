//
//  WHKTableViewZeroCell.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHKTableViewZeroCell : UITableViewCell

@property (nonatomic, strong) UIView * lineTop;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
