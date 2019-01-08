//
//  LeftMenuViewController.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/3/29.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "BN_TabBarView.h"

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray * titleMarr;
//
//@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
//@property (nonatomic, strong) UIView *containView;


@property (strong, nonatomic) BN_TabBarView *tabBarView;

@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSMutableArray *itemList;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.controllerName;

    //    [self.view addSubview:self.tableView];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self createBarItemTitle:@"+" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, UIButton *item, NSInteger idx) {
        [self add:item];
    }];
    
//    [self createBarItemTitle:@"+" imageName:nil isLeft:YES isHidden:NO handler:^(id obj, UIButton *item, NSInteger idx) {
//        [self jian:item];
//    }];
    self.itemList = [NSMutableArray arrayWithCapacity:0];
    
    self.itemList = @[@"abc",@"eeee",@"gggg",@"mmmm"].mutableCopy;
    [self initSlideWithCount];
}

- (void)jian:(id)sender {
    [self.itemList removeLastObject];
    
    [self initSlideWithCount];
}


- (void)add:(id)sender {
    NSString * item = [NSString stringWithFormat:@"item%@",@(self.itemList.count)];
    [self.itemList addObject:item];
    
    [self initSlideWithCount];
}

-(void) initSlideWithCount{
    [_tabBarView removeFromSuperview];
    
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    //    _tabBarView = [[BINTabBarView alloc] initWithFrame:rect items:self.itemList];
    _tabBarView = [BN_TabBarView viewRect:rect items:self.itemList];
    [self.view addSubview:_tabBarView];
    _tabBarView.selectedPage = 1;
    
    [self initDataSource];
    for (UITableView * tableView in _tabBarView.scrollTableViews) {
        tableView.dataSource = self;
        tableView.delegate = self;
        
    }
}

-(void) initDataSource{
    _dataList = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i <= _tabBarView.items.count; i ++) {
        
        NSMutableArray *tempArray  = [NSMutableArray arrayWithCapacity:0];
        for (int j = 1; j <= 10; j ++) {
            
            NSString *tempStr = [NSString stringWithFormat:@"第%d个TableView的第%d条数据。", i, j];
            [tempArray addObject:tempStr];
        }
        [_dataList addObject:tempArray];
    }
}

#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSMutableArray *tempArray = _dataList[_currentPage];
    //    return tempArray.count;
    return [_dataList[section] count];
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //    cell.backgroundColor = [UIColor orangeColor];
    
    //    if ([tableView isEqual:_scrollTableViews[_currentPage%2]]) {
    //        cell.textLabel.text = _dataList[_currentPage][indexPath.row];
    //    }
    NSString * title = _dataList[_tabBarView.segmentCtrl.selectedSegmentIndex][indexPath.row];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [@(tableView.tag) stringValue];
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
