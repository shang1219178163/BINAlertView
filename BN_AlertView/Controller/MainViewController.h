//
//  MainViewController.h
//  CustomeAlertView
//
//  Created by Shang on 14-10-16.
//  Copyright (c) 2014年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"
#import "MyView.h"

@interface MainViewController : UIViewController<MyViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) MyView * myView;

@end
