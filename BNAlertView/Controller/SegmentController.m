//
//  SegmentController.m
//  BN_AlertView
//
//  Created by hsf on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "SegmentController.h"

#import "BN_SegmentControl.h"

@interface SegmentController ()

@end

@implementation SegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    BN_SegmentControl *control = [[BN_SegmentControl alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, 40)];
    control.titles = @[@"Library", @"Trending", @"News"];
    control.tag = 1;
    control.isIndicatorTop = YES;
    [control addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
    
    
    BN_SegmentControl *control2 = [[BN_SegmentControl alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 50)];
    control2.titles = @[@"One", @"Two", @"Three", @"4", @"Five", @"Six",
                        @"Seven",@"Eight",@"Nine",@"Ten",@"eleven",@"twelve",
                        @"thirteen",@"fourteen",@"fifteen",@"sixteen",@"seventeen",
                        @"eighteen",@"nineteen",@"twenty",@"twenty-one",@"twenty-two",
                        @"twenty-three",@"twenty-four",@"twenty-five",@"twenty-six",@"twenty-seven",
                        @"twenty-eight",@"twenty-nine",@"thirty"];
    control2.block = ^(BN_SegmentControl *view, NSUInteger index) {
        NSLog(@"Selected index %lu (via block)", (unsigned long)index);
        
    };
    
    control2.h_indicator = 4.0f;
    control2.backgroundColor = UIColor.blackColor;
    control2.textColor = UIColor.whiteColor;
    control2.indicatorColor = UIColor.redColor;
    
    control2.backgroundColor = UIColorHexValue(0x3498db);
    control2.backgroundColor = UIColorHexValue(0x3498db);

    control2.textColor = UIColor.whiteColor;
    control2.textColor_H = UIColorHexValue(0x34495e);
    control2.textColor_H = UIColor.redColor;

    control2.indicatorColor = UIColorHexValue(0x34495e);
    
//    control2.indicatorSizeMode = BN_IndicatorSizeToFill;
//    control2.indicatorMode = BN_IndicatorBox;
    control2.isIndicatorTop = NO;
    control2.isScroll = YES;
//    control2.segmentEdgeInset = UIEdgeInsetsMake(0, 6, 0, 6);
    control2.center = CGPointMake((kScreenWidth)/2, 120);
    control2.tag = 2;
    [self.view addSubview:control2];
    
    
    
    BN_SegmentControl *control3 = [[BN_SegmentControl alloc] initWithFrame:CGRectMake(10, 150, kScreenWidth - 20, 50)];
    NSLog(@"!!!framY:%.2f,    H:%.2f",control3.frame.origin.y,control3.frame.size.height);
    control3.titles = @[@"Worldwide", @"Local", @"Headlines"];
    control3.selectedIndex = 1;
    control3.backgroundColor = UIColor.lightGrayColor;
    control3.textColor = UIColor.whiteColor;
    control3.indicatorColor = UIColor.blackColor;
    control3.tag = 3;
    [self.view addSubview:control3];
    
    
    NSArray *titles = @[@"1", @"2222", @"33333", @"4"];
    NSArray *images = @[@"1",@"2",@"3",@"4"];
    NSArray *selectedImages = @[@"1-selected",@"2-selected",@"3-selected",@"4-selected"];

    
    BN_SegmentControl *control4 = [[BN_SegmentControl alloc] initWithFrame:CGRectMake(10, 220, kScreenWidth - 20, 50)];
    control4.titles = titles;
    control4.images = images;
    control4.selectedImages = selectedImages;

    control4.type = BN_ControlTypeTextImage;
    control4.iconMode = BN_ImgTypeRight;

    control4.indicatorMode = BN_IndicatorBox;

    control4.backgroundColor = UIColorHexValue(0x3498db);
    control4.textColor = UIColor.whiteColor;
    control4.textColor_H = UIColorHexValue(0x34495e);
    control4.textColor_H = UIColor.redColor;

    control4.indicatorColor = UIColorHexValue(0x34495e);
    
    control4.tag = 1;
    control4.isIndicatorTop = YES;
    [control4 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control4];
    
    NSArray *titles5 = @[@"1", @"2222", @"33333", @"4"];
    NSArray *images5 = @[@"1",@"2",@"3",@"4"];
    NSArray *selectedImages5 = @[@"1-selected",@"2-selected",@"3-selected",@"4-selected"];
    
    BN_SegmentControl *control5 = [[BN_SegmentControl alloc] initWithFrame:CGRectMake(10, 300, kScreenWidth - 20, 50)];
    control5.titles = titles5;
    control5.images = images5;
    control5.selectedImages = selectedImages5;
    
    control5.type = BN_ControlTypeTextImage;
//    control5.iconMode = BN_ImgTypeRight;
    control5.imgSize = CGSizeMake(35, 35);
    
    control5.indicatorMode = BN_IndicatorBox;
    
    control5.backgroundColor = UIColorHexValue(0x3498db);
    control5.textColor = UIColor.whiteColor;
    control5.textColor_H = UIColorHexValue(0x34495e);
    control5.textColor_H = UIColor.redColor;
    
    control5.indicatorColor = UIColorHexValue(0x34495e);
    
    control5.tag = 1;
    control5.isIndicatorTop = YES;
    [control5 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control5];
    
    [self.view getViewLayer];
}

- (void)segmentedControlChangedValue:(BN_SegmentControl *)segmentedControl {
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
