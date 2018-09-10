//
//  DesignPatternsController.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/28.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "DesignPatternsController.h"

@interface DesignPatternsController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation DesignPatternsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //    cell.backgroundColor = [UIColor orangeColor];
    
    cell.imageView.image = [UIImage imageNamed:@"dragon"];
    cell.textLabel.text = @"title";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"row__%ld",indexPath.row];
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame),  CGRectGetHeight(cell.frame))];
    backgroudView.backgroundColor = [UIColor cyanColor];
    cell.selectedBackgroundView = backgroudView;
    
    //    NSLog(@"cell-%ld",(long)indexPath.row);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma mark - -layz
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
            tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//确保TablView能够正确的调整大小
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //        tableView.separatorColor = kC_LineColor;
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
            
            tableView;
        });
    }
    return _tableView;
}

@end
