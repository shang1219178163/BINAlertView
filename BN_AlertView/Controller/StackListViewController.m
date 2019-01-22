//
//  StackListViewController.m
//  CustomeAlertView
//
//  Created by hsf on 2017/11/20.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "StackListViewController.h"

#import "UIView+Helper.h"
#import "UIView+AddView.h"

#import "WHKTableViewZeroCell.h"
#import "WHKTableViewFiftyFiveCell.h"

#import "BINTabBarView.h"

@interface StackListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * titleMarr;

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
@property (nonatomic, strong) UIView *containView;


@property (strong, nonatomic) BINTabBarView *tabBarView;
@property (assign) NSInteger tabCount;

@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSMutableArray *itemList;

@end

@implementation StackListViewController

-(UISegmentedControl *)segmentCtrl{
    if (!_segmentCtrl) {
        /*********************************************************************/
        _segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"今天",@"昨天",@"前天",@"item"]];
        _segmentCtrl.frame = CGRectMake(0, kScreenHeight/2.0, kScreenWidth, 44);
        _segmentCtrl.backgroundColor = UIColor.whiteColor;
        _segmentCtrl.tintColor = [UIColor cyanColor];
        _segmentCtrl.selectedSegmentIndex = 0;
        _segmentCtrl.layer.borderWidth = 1;
        _segmentCtrl.layer.borderColor = UIColor.whiteColor.CGColor;
        
        NSDictionary * dict = @{
                                NSForegroundColorAttributeName :   [UIColor blackColor],
                                NSFontAttributeName            :   [UIFont systemFontOfSize:14],
                                
                                };
        
        [_segmentCtrl setTitleTextAttributes:dict forState:UIControlStateNormal];
//        [_segmentCtrl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        
        //    [_segmentCtrl setDividerImage:[UIImage imageNamed:@"31"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segmentCtrl setDividerImage:[UIImage imageWithColor:UIColor.whiteColor] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    return _segmentCtrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.controllerName;

//    [self.view addSubview:self.tableView];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
    [self createBarItemTitle:@"+" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, UIButton *item, NSInteger idx) {
        NSString * element = [NSString stringWithFormat:@"item%@",@(self.itemList.count)];
        [self.itemList addObject:element];
        
        [self initSlideWithCount];
    }];


    self.itemList = [NSMutableArray arrayWithCapacity:0];
    
    self.itemList = @[@"abc",@"eeee",@"gggg "].mutableCopy;
    [self initSlideWithCount];
}

- (void)jian:(id)sender {
    [self.itemList removeLastObject];
    
    [self initSlideWithCount];
}

-(void) initSlideWithCount{
    [_tabBarView removeFromSuperview];

    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
//    _tabBarView = [[BINTabBarView alloc] initWithFrame:rect items:self.itemList];
    _tabBarView = [BINTabBarView viewRect:rect items:self.itemList];
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
    NSString * title = _dataList[_tabBarView.currentPage][indexPath.row];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [@(tableView.tag) stringValue];
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
