//
//  CycleViewController.m
//  BNAlertView
//
//  Created by hsf on 2018/11/2.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "CycleViewController.h"

@interface CycleViewController ()

@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"scollView循环";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
