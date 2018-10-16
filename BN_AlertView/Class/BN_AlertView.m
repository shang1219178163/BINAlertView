
//
//  BN_AlertView.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_AlertView.h"

@interface BN_AlertView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation BN_AlertView

-(instancetype)init{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, kScreen_width, kScreen_height);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
        [self addGestureRecognizer:tap];
        
        
        self.tableView.frame = self.bounds;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.dataList = [NSArray arrayWithItemPrefix:@"工厂_" startIndex:1 count:26 type:@0];

    }
    return self;
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.frame) * 0.66, CGRectGetHeight(self.frame) - kH_CellHeight*2);
    CGFloat height = (_dataList.count + 1)*kH_CellHeight < maxSize.height ? (_dataList.count + 1)*kH_CellHeight : maxSize.height;
    
    
    CGRect rect = self.tableView.frame;
    rect.size.width = maxSize.width;
    rect.size.height = height;
    self.tableView.frame = rect;
    
    self.tableView.center = self.center;
    
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    self.indexPath = self.indexPath ? self.indexPath : [NSIndexPath indexPathForRow:0 inSection:0];
    [self dismiss];
    if (self.block) {
        self.block(self, self.indexPath);
    }
}

- (void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [window addSubview:self.tableView];
    
    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 1;
        
//        CGRect tempFrame = self.tableView.frame;
//        tempFrame.size.height = kScreen_height/2.0;
//        self.tableView.frame = tempFrame;
        
    } completion:nil];
}

- (void)dismiss{
    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 0;
        
//        CGRect tempFrame = self.tableView.frame;
//        tempFrame.size.height = 0;
//        self.tableView.frame = tempFrame;
        
    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

#pragma mark - -UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kH_CellHeight;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.dataList.count > 0 ? self.dataList.count : 1;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.dataList.count > 0) {
        cell.textLabel.text = self.dataList[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        cell.textLabel.text = @"没有符合条件的数据,去看看其他内容吧!";
        
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.indexPath != indexPath) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.indexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        self.indexPath = indexPath.copy;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    self.indexPath = indexPath;
    [self dismiss];
    if (self.block) {
        self.block(self, self.indexPath);
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kH_CellHeight;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"请选择";
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.themeColor;

    return label;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    return [UIView new];
//}


#pragma mark - -layz

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//确保TablView能够正确的调整大小
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //        tableView.separatorColor = UIColor.lineColor;
            tableView.backgroundColor = [UIColor greenColor];
            //        tableView.backgroundColor = kC_BackgroudColor;
            
            tableView.estimatedRowHeight = 0.0;
            tableView.estimatedSectionHeaderHeight = 0.0;
            tableView.estimatedSectionFooterHeight = 0.0;
            tableView.rowHeight = 50;
            
            //背景视图
            //            UIView *view = [[UIView alloc]initWithFrame:tableView.bounds];
            //            view.backgroundColor = [UIColor cyanColor];
            //            tableView.backgroundView = view;
            tableView.bounces = NO;
            tableView;
        });
    }
    return _tableView;
}


@end
