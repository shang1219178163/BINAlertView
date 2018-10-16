//
//  BNNavigationController.m
//  ProductTemplet
//
//  Created by hsf on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNNavigationController.h"

@interface BNNavigationController ()

@end

@implementation BNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //点击返回按钮，将所有的文本框失焦
    //    [[UIApplication sharedApplication] resignFirstResponder];
    //    [self.navigationController popViewControllerAnimated:YES];
    //    [self setNavStyles];
    self.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置导航条样式
- (void)setNavStyles{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
    //    bar.barTintColor = [UIColor colorWithRed:62/255.0 green:173/255.0 blue:176/255.0 alpha:1.0];
    bar.barTintColor = UIColor.orangeColor;
    
    //设置字体颜色
    bar.tintColor = UIColor.whiteColor;//左右两边字体颜色
    bar.titleTextAttributes = @{
                                NSForegroundColorAttributeName : UIColor.whiteColor
                                
                                };
    
    //替换原来的返回图片
    //    bar.backIndicatorImage = [UIImage imageNamed:@"icon_back"];
    //    bar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"icon_back"];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if ([self.viewControllers containsObject:viewController]) return;
    [super pushViewController:viewController animated:animated];
}

//#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    // 输出点击的view的类名
//    DDLog(@"%@", NSStringFromClass([touch.view class]));
//
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
////    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
////        return NO;
////    }
//    return  YES;
//}

@end
