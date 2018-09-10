//
//  ControlViewController.m
//  BN_AlertView
//
//  Created by hsf on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "ControlViewController.h"

#import "BN_SegmentedControl.h"

@interface ControlViewController ()

@end

@implementation ControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    BN_SegmentedControl *control = [[BN_SegmentedControl alloc] initWithSectionTitles:@[@"Library", @"Trending", @"News"]];
    control.frame = CGRectMake(10, 40, 300, 40);
    control.tag = 1;
    control.isIndicatorTop = YES;
    [control addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
    
    
    BN_SegmentedControl *control2 = [[BN_SegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three", @"4", @"Five"]];
    control2.block = ^(BN_SegmentedControl *view, NSUInteger index) {
        NSLog(@"Selected index %lu (via block)", (unsigned long)index);
        
    };
    
    control2.h_indicator = 4.0f;
    control2.backgroundColor = UIColor.blackColor;
    control2.textColor = UIColor.whiteColor;
    control2.indicatorColor = UIColor.redColor;
    control2.indicatorMode = BN_IndicatorFillsSegment;
    control2.isIndicatorTop = NO;
    control2.segmentEdgeInset = UIEdgeInsetsMake(0, 6, 0, 6);
    control2.center = CGPointMake(160, 120);
    control2.tag = 2;
    [self.view addSubview:control2];
    
    
    
    BN_SegmentedControl *control3 = [[BN_SegmentedControl alloc] initWithFrame:CGRectMake(10, 200, 300, 50)];
    NSLog(@"!!!framY:%.2f,    H:%.2f",control3.frame.origin.y,control3.frame.size.height);
    control3.list = @[@"Worldwide", @"Local", @"Headlines"];
    control3.selectedIndex = 1;
    control3.backgroundColor = UIColor.lightGrayColor;
    control3.textColor = UIColor.whiteColor;
    control3.indicatorColor = UIColor.blackColor;
    control3.tag = 3;
    [self.view addSubview:control3];
    
    [self.view getViewLayer];
}

- (void)segmentedControlChangedValue:(BN_SegmentedControl *)segmentedControl {
    NSLog(@"Selected index %i (via UIControlEventValueChanged)", segmentedControl.selectedIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
