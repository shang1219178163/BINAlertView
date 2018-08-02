//
//  BINTableViewHandleSections.h
//  WeiHouBao
//
//  Created by hsf on 2017/9/26.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;

typedef UITableViewCell* (^ReturnCellBlock)(UITableView * tableView,NSIndexPath *indexPath, id item) ;

typedef void    (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;

typedef CGFloat (^ReturnSectionViewHeightBlock)(NSInteger section, BOOL isHeader) ;

typedef UIView* (^ReturnSectionViewBlock)(NSInteger section, BOOL isHeader) ;

@interface BINTableViewHandleSections : NSObject

- (id)initWithItems:(NSArray *)anItems
    cellHeightBlock:(CellHeightBlock)aHeightBlock
    returnCellBlock:(ReturnCellBlock)returnCellBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock;

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table ;

@property (nonatomic, copy) ReturnSectionViewBlock  returnSectionViewBlock;
@property (nonatomic, copy) ReturnSectionViewHeightBlock  returnSectionViewHeightBlock;

@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, assign) NSInteger sectionRowCount;

@end
