
//
//  BNMenuView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/16.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNMenuView.h"

#import "BNGloble.h"
#import "BNCategory.h"

static CGFloat kH_Top = 64.0;

@interface BNMenuView ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, strong) NSArray * dataList;
@property (nonatomic, strong) UITableView * tableView;


@end

@implementation BNMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.dataList = [NSArray arrayItemPrefix:@"工厂_" startIndex:1 count:10 type:@0];        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.tableView.frame = CGRectMake(0, kH_Top, kScreenWidth, 0);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)setIsShow:(BOOL)isShow{
    _isShow = isShow;
    if (_isShow) {
        [self show];
    } else {
        [self dismiss];
    }
   
}

- (void)show{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;

    self.frame = CGRectMake(0, kH_Top, kScreenWidth, kScreenHeight - kH_Top);
    [window addSubview:self];
    [window addSubview:self.tableView];

    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 1;
        
        CGRect tempFrame = self.tableView.frame;
        tempFrame.size.height = kScreenHeight/2.0;
        self.tableView.frame = tempFrame;
        
    } completion:nil];
}

- (void)dismiss{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0;
        
        CGRect tempFrame = self.tableView.frame;
        tempFrame.size.height = 0;
        self.tableView.frame = tempFrame;
        
    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    self.indexPath = self.indexPath ? self.indexPath : [NSIndexPath indexPathForRow:0 inSection:0];
    self.isShow = NO;
//    [self dismiss];
    if (self.block) {
        self.block(self, self.indexPath);
    }
}

#pragma mark - -UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
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
    } else {
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
    self.isShow = NO;
//    [self dismiss];
    if (self.block) {
        self.block(self, self.indexPath);
    }

}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    NSString *text = [NSString stringWithFormat:@"共搜索到%@条符合条件的数据",@(self.resultList.count)];
//    return text;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
////    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
////    return label;
//
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    return [UIView new];
//}

//-(void)setData:(id)data{
//    _data = data;
//    
//    NSParameterAssert([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]);
//    if ([data isKindOfClass:[NSArray class]]) {
////        self.dataList = [self.data sortedByAscending];
//        
//    }
//    else if ([data isKindOfClass:[NSDictionary class]]) {
////        self.dataList = [self.data sortedValuesByKey];
//        
//    }
//    [self.tableView reloadData];
//
//}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    [self.tableView reloadData];
    
}


#pragma mark - -layz

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
            tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorInset = UIEdgeInsetsZero;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //        tableView.separatorColor = UIColor.lineColor;
            tableView.backgroundColor = UIColor.greenColor;
            tableView.backgroundColor = UIColor.backgroudColor;
            
            tableView.estimatedRowHeight = 0.0;
            tableView.estimatedSectionHeaderHeight = 0.0;
            tableView.estimatedSectionFooterHeight = 0.0;
            tableView.rowHeight = 50;
            
            //背景视图
            //            UIView *view = [[UIView alloc]initWithFrame:tableView.bounds];
            //            view.backgroundColor = UIColor.cyanColor;
            //            tableView.backgroundView = view;
            
            tableView;
        });
    }
    return _tableView;
}

//-(UIView *)blackView{
//    if (!_blackView) {
//        _blackView = ({
//            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, kH_Top, kScreenWidth, kScreenHeight - kH_Top)];
//            view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//
//            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
//            [view addGestureRecognizer:tap];
//
//            view;
//        });
//    }
//    return _blackView;
//}

@end
