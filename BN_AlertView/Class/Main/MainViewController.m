//
//  MainViewController.m
//  CustomeAlertView
//
//  Created by Shang on 14-10-16.
//  Copyright (c) 2014年 SouFun. All rights reserved.
//

#import "MainViewController.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "MyView.h"
#import "BN_AlertViewZero.h"
#import "BN_RangeDateView.h"

#import "BN_AlertView.h"
#import "BN_AlertViewOne.h"
#import "BN_AlertViewTwo.h"

#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define kCOUNT_IMAGEVIEW 6
#define kTAG_IMGVIEW 300

#import "NextViewController.h"

@interface MainViewController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) BN_RangeDateView * dateView;

@end

@implementation MainViewController

#pragma mark - - layz
-(BN_RangeDateView *)dateView{
    if (!_dateView) {
        _dateView = [[BN_RangeDateView alloc]initWithFrame:CGRectMake(20, 250, kScreen_width*0.66, 44)];
        _dateView.block = ^(BN_RangeDateView *view, NSString *dateStart, NSString *dateEnd) {
            //            DDLog(@"_%@___%@_",[dateStart toTimestampShort], [dateEnd toTimestampFull]);
            //            DDLog(@"_%@___%@_",[view.dateStart toTimestampShort], [view.dateEnd toTimestampFull]);

            
        };
    }
    return _dateView;
}


-(NSArray *)itemList{
    if (!_itemList) {
        _itemList = [NSArray arrayWithItemPrefix:@"btn_" startIndex:0 count:16 type:@0];
    }
    return _itemList;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    self.title = @"Main";
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self addRightBtn];
    
    CGRect rect = CGRectMake(20, 20, kScreen_width - 20*2, 0);
    UIView * containView = [UIView createViewWithRect:rect items:self.itemList numberOfRow:4 itemHeight:30 padding:10 type:@0 handler:^(id obj, id item, NSInteger idx) {
        [self handleActionBtn:item];
        
    }];
    containView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:containView];
    
    [self.view addSubview:self.dateView];
    
//    [self.view getViewLayer];
    
}

- (void)handleActionBtn:(UIButton *)sender{
    DDLog(@"%@",@(sender.tag));
    switch (sender.tag) {
        case 0:
        {
            UIAlertController * alerController = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
            
            [alerController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alerController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alerController animated:YES completion:nil];
        }
            break;
        case 1:
        {
            BN_AlertViewZero * alertView = [BN_AlertViewZero alertViewWithTitle:@"title" message:@"只用了两年时间，天津东边的一片盐碱地，就让创造了蛇口神话的袁庚都为之紧张。……" customView:nil btnTitles:@[@"取消",@"确认"]];
            [alertView show];
            [alertView actionWithBlock:^(BN_AlertViewZero *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
                
                
            }];
            
            [alertView getViewLayer];
            
        }
            break;
        case 2:
        {
            BN_AlertView * alertView = [[BN_AlertView alloc]init];
            alertView.dataList = [NSArray arrayWithItemPrefix:@"测试_" startIndex:1 count:22 type:@0];

            [alertView show];
            
        }
            break;
        case 3:
        {
            BN_AlertViewOne * alertView = [[BN_AlertViewOne alloc]init];
//            alertView.dataList = [NSArray arrayWithItemPrefix:@"测试_" startIndex:1 count:22 type:@0];
            
            [alertView show];
            alertView.block = ^(BN_AlertViewOne *view, NSIndexPath *indexPath) {
              DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row))
            };
            
        }
            break;
        case 4:
        {
            BN_AlertViewTwo * alertView = [[BN_AlertViewTwo alloc]init];
            alertView.label.text = nil;
            alertView.imgView.image = [UIImage imageNamed:@"警告.png"];
            alertView.labelSub.text = @"只用了两年时间，天津东边的一片盐碱地，就让创造了蛇口神话的袁庚都为之紧张。……";
            alertView.items = @[@"取消",@"确定"];
            [alertView show];
            alertView.block = ^(BN_AlertViewTwo *view, NSInteger idx) {
                DDLog(@"%@",@(idx))
            };
            [alertView getViewLayer];

        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
        case 9:
        {
            
        }
            break;
        default:
            break;
    }
    
    
}
-(void)openDocument:(NSString *)fileName{
    
    NSArray *fileNameList = [fileName componentsSeparatedByString:@"."];
    NSString * filePath = [NSBundle.mainBundle pathForResource:fileNameList.firstObject ofType:fileNameList.lastObject];
    
    UIDocumentInteractionController * documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    documentController.delegate = self;
    
    documentController.UTI = @"com.adobe.pdf";//You need to set the UTI (Uniform Type Identifiers) for the documentController object so that it can help the system find the appropriate application to open your document. In this case, it is set to “com.adobe.pdf”, which represents a PDF document. Other common UTIs are "com.apple.quicktime-movie" (QuickTime movies), "public.html" (HTML documents), and "public.jpeg" (JPEG files)
    
    [documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    
}


- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
    NSLog(@"onClickedOKbtn");
    NextViewController * viewController = [NextViewController new];
    [self.navigationController pushViewController:viewController animated:YES];
    
}


//createSpeakStartView
-(UIView *)createStarsWithStarCount:(NSInteger)starCount hasGesture:(BOOL)hasGesture target:(id)target aSelector:(SEL)aSelector{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 100, 30)];
    
    view.backgroundColor = [UIColor greenColor];

    CGFloat paddding = 5.0;
    
    NSInteger count = 5;
    CGFloat imgWH = (CGRectGetWidth(view.frame) - (count - 1) * paddding)/count;

    for (int i = 0; i < count; i++) {
        
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake((imgWH + paddding) * i, 0, imgWH, imgWH)];
        imgV.backgroundColor = [UIColor yellowColor];
        imgV.image = [UIImage imageNamed:@"star.png"];
        imgV.tag = kTAG_IMGVIEW + i;
        
        if(hasGesture == YES){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:aSelector];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            imgV.userInteractionEnabled = YES;
            [imgV addGestureRecognizer:tap];
            
        }
        [view addSubview:imgV];
    }
    
    return view;
}

- (void)launchDialog:(UIButton *)sender{
    
//    CustomAlertView * alert = [[CustomAlertView alloc]initWithTitle:@"11111" message:@"222" orCustomeView:nil delegate:self buttonTitles:[NSArray arrayWithObjects:@"cancell",@"ok", nil]];
//
//    alert.parView = self.view;
//    [alert showCustomAlertView];
    
    
//    MyView * grayView = [[MyView alloc]initWithFrame:CGRectZero Title:@"title" message:@"msg" orCustomeView:[self createView] delegate:self buttonTitles:[NSArray arrayWithObjects:@"cancell",@"ok", nil]];
    MyView * grayView = [[MyView alloc]initWithFrame:CGRectZero Title:@"title" message:@"msg" orCustomeView:[self createSpeakStartView] delegate:self buttonTitles:[NSArray arrayWithObjects:@"cancell",@"ok", nil]];

    [grayView showMyView];
    grayView.tag = 105;
    
    return;

}

-(void)customViewButtonTouchUpInside:(UIView *)myView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"___%ld",(long)buttonIndex);
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
//加tableview
-(UIView *)createView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    view.backgroundColor = [UIColor redColor];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), 0.1)];
    [view addSubview:tableView];
//    tableView.backgroundColor = [UIColor yellowColor];
    return view;
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
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    MyView * myView = (MyView *)[window viewWithTag:105];
    [myView dismissMyView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
//createSpeakStartView
-(UIView *)createSpeakStartView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, 30)];
    //    UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
    
    view.backgroundColor = [UIColor clearColor];
    view.tag = 333;
//    view.layer.masksToBounds = YES;
//    view.layer.cornerRadius = 8;
//    view.layer.borderWidth = 0.5;
//    view.layer.borderColor = [UIColor cyanColor].CGColor;
    
    
    NSInteger count = kCOUNT_IMAGEVIEW;
    CGFloat imgWH = (kScreen_width - 25 * 2 - (kCOUNT_IMAGEVIEW - 1) * 5)/kCOUNT_IMAGEVIEW;
    view.frame = CGRectMake(0, 0, kScreen_width, imgWH+5);
    for (int i = 0; i < count; i++) {
        
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (imgWH + 5) * i , 0, imgWH, imgWH)];
        imgV.backgroundColor = [UIColor yellowColor];
        imgV.image = [UIImage imageNamed:@"star.png"];
        imgV.tag = kTAG_IMGVIEW + i;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapStar:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        imgV.userInteractionEnabled = YES;
        [imgV addGestureRecognizer:tap];
        
        [view addSubview:imgV];
    }
    
    return view;
}

-(void)tapStar:(UITapGestureRecognizer *)tap{
   
    NSLog(@"i8 mg_%ld",(long)tap.view.tag);
//    UIWindow * window  = [[UIApplication sharedApplication] keyWindow];
    for (int i = kTAG_IMGVIEW; i < kTAG_IMGVIEW + kCOUNT_IMAGEVIEW ; i++) {
        
        UIImageView * imgV = (UIImageView *)[tap.view.superview viewWithTag:i];
//        imgV.image = [UIImage imageNamed:@"star_n.jpg"];
        imgV.image = [UIImage imageNamed:@"star"];

        if (i <= tap.view.tag) {
            
            UIImageView * imgV = (UIImageView *)[tap.view.superview viewWithTag:i];
            imgV.image = [UIImage imageNamed:@"star_h.jpg"];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
