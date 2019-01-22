//
//  HomeViewController.m
//  BN_AlertView
//
//  Created by Bin Shang on 2019/1/22.
//  Copyright © 2019 SouFun. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSArray * filterList;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
    
    [self createBarItemTitle:@"Tap" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, UIButton * item, NSInteger idx) {
       
    }];
    
    self.dataList = @[
                      @[
                          @"MainNewViewController",@"MainNewViewController",
                          ],
                      @[
                          @"MainViewController",@"MainViewController",
                          ],
                      @[
                          @"NextViewController",@"NextViewController",
                          ],
                      @[
                          @"TmpViewController",@"TmpViewController",
                          ],
                      @[
                          @"SegmentController",@"SegmentController",
                          ],
                      @[
                          @"ContactListController",@"ContactListController",
                          ],
                      @[
                          @"CycleViewController",@"CycleViewController",
                          ],
                      @[
                          @"AnimationController",@"AnimationController",
                          
                          ],
                    
                      ].mutableCopy;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)configureTableView{
    self.tableView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
}

#pragma mark - -UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.dataList.count > 0 ? self.dataList.count : 1;
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * list = self.dataList[indexPath.row];

    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = list.firstObject;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * list = self.dataList[indexPath.row];
    [self goController:list.lastObject title:list.firstObject];
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

