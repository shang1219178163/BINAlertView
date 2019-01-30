//
//  BNTablePlainView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 列表数据展示通用
 */
@interface BNTablePlainView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * list;
@property (nonatomic, copy) UITableViewCell *(^blockCellForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void(^blockDidSelectRow)(UITableView* tableView, NSIndexPath* indexPath);
@end

