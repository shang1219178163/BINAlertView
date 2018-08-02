//
//  UIViewController+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+Helper.h"
#import <objc/runtime.h>

#import <StoreKit/StoreKit.h>

#import "UIButton+Helper.h"

@implementation UIViewController (Helper)

@dynamic delegate;

#pragma make - - 给控制器添加额外属性
-(UIViewController *)frontController{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setFrontController:(UIViewController *)frontController{
    objc_setAssociatedObject(self, @selector(frontController), frontController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UIViewController *)frontVC{
    return [self frontViewController:self.navigationController];
    
}

-(void)setFrontVC:(UIViewController *)frontVC{
    objc_setAssociatedObject(self, @selector(frontVC), frontVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(NSDictionary *)controllerDict{
    return objc_getAssociatedObject(self, _cmd);

}

-(void)setControllerDict:(NSDictionary *)controllerDict{
    objc_setAssociatedObject(self, @selector(controllerDict), controllerDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(NSString *)controllerType{
    return objc_getAssociatedObject(self, _cmd);

}

-(void)setControllerType:(NSString *)controllerType{
    objc_setAssociatedObject(self, @selector(controllerType), controllerType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

#pragma make - - 声明代码块

-(BlockAlertController)blockAlertController{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setBlockAlertController:(BlockAlertController)blockAlertController{
    objc_setAssociatedObject(self, @selector(blockAlertController), blockAlertController, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

#pragma make - -网络请求失败加载图

- (void)addFailRefreshViewWithTitle:(NSString *)title{
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        view.hidden = NO;
        return;
    }
    view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.tag = 20178015;
    view.backgroundColor = [UIColor whiteColor];
    
    CGSize imgSize = CGSizeMake(65, 75);
    CGRect imgViewRect = CGRectMake((kScreen_width - imgSize.width)/2.0, (CGRectGetHeight(self.view.bounds) - imgSize.height)/2.0, imgSize.width, imgSize.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgViewRect];
    imageView.image = [UIImage imageNamed:@"error.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kX_GAP, CGRectGetMaxY(imgViewRect)+5, kScreen_width - 2 * kX_GAP, 30)];
    tipLabel.text = title;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.userInteractionEnabled = YES;

//    tipLabel.backgroundColor = [UIColor yellowColor];
//    imageView.backgroundColor = [UIColor greenColor];

    [view addSubview:tipLabel];
    [view addSubview:imageView];
    
    if ([self respondsToSelector:@selector(failRefresh)]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(failRefresh)];
        
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        [view addGestureRecognizer:tapGesture];
    }
    
    [self.view addSubview:view];
}

- (void)removeFailRefreshView{
    
    if ([self.view viewWithTag:20178015] && [self.view viewWithTag:20181019]) {
        UIView *view = [self.view viewWithTag:20178015];
        UIView *viewNoData = [self.view viewWithTag:20181019];
        view.hidden = YES;
        viewNoData.hidden = YES;
        return;
    }
        
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        view.hidden = YES;
    }
    
    UIView *viewNoData = [self.view viewWithTag:20181019];
    if (viewNoData) viewNoData.hidden = YES;
    
}

- (void)addNoDataRefreshViewWithTitle:(NSString *)title{
    UIView *view = [self.view viewWithTag:20181019];
    if (view) {
        view.hidden = NO;
        return;
    }
    view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.tag = 20181019;
    view.backgroundColor = [UIColor whiteColor];
    
    CGSize imgSize = CGSizeMake(65, 75);
    CGRect imgViewRect = CGRectMake((kScreen_width - imgSize.width)/2.0, (CGRectGetHeight(self.view.bounds) - imgSize.height)/2.0, imgSize.width, imgSize.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgViewRect];
    imageView.image = [UIImage imageNamed:@"mo_nor.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kX_GAP, CGRectGetMaxY(imgViewRect)+5, kScreen_width - 2 * kX_GAP, 30)];
    tipLabel.text = title;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.userInteractionEnabled = YES;
    
    //    tipLabel.backgroundColor = [UIColor yellowColor];
    //    imageView.backgroundColor = [UIColor greenColor];
    
    [view addSubview:tipLabel];
    [view addSubview:imageView];
    
    if ([self respondsToSelector:@selector(failRefresh)]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(failRefresh)];
        
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        [view addGestureRecognizer:tapGesture];
    }
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    
}


/**
 失败或者无数据视图(新app启用)
 */
- (void)addRefreshViewTitle:(NSString *)title image:(NSString *)image{
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        [self.view setHidden:NO];
        return;
    }
    view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.tag = 20178015;
    view.backgroundColor = [UIColor whiteColor];
    
    CGSize imgSize = CGSizeMake(65, 75);
    CGRect imgViewRect = CGRectMake((kScreen_width - imgSize.width)/2.0, (CGRectGetHeight(self.view.bounds) - imgSize.height)/2.0, imgSize.width, imgSize.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgViewRect];
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kX_GAP, CGRectGetMaxY(imgViewRect)+5, kScreen_width - 2 * kX_GAP, 30)];
    tipLabel.text = title;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.userInteractionEnabled = YES;
    
    //    tipLabel.backgroundColor = [UIColor yellowColor];
    //    imageView.backgroundColor = [UIColor greenColor];
    
    [view addSubview:tipLabel];
    [view addSubview:imageView];
    
    if ([self respondsToSelector:@selector(failRefresh)]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(failRefresh)];
        
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        [view addGestureRecognizer:tapGesture];
    }
    [self.view addSubview:view];
}

-(NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_ASSIGN);
}

#pragma make - -通用
- (UIButton *)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target aSelector:(SEL)aSelector isHidden:(BOOL)isHidden{
    
    UIButton * btn = nil;
    if (imageName) {
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40) image_N:imageName image_H:nil imageEdgeInsets:UIEdgeInsetsZero];
    }else{
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40) title:title font:15 titleColor_N:nil titleColor_H:nil titleEdgeInsets:UIEdgeInsetsZero];
       
    }
    btn.tag = isLeft == YES ? kTAG_BTN_BackItem : kTAG_BTN_RightItem;
    
    [btn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    btn.hidden = isHidden;

    //
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn.center = view.center;
    [view addSubview:btn];

    //统一走父视图方法
    [btn removeTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    //父视图调用子视图方法参数
    [view addActionHandler:^(id obj, id item, NSInteger idx) {
        
        if (btn.hidden == YES) return ;
        if (NSDate.date.timeIntervalSince1970 - self.timeInterval < 1) return;
        if (self.timeInterval > 0) self.timeInterval = NSDate.date.timeIntervalSince1970;

        [target performSelectorOnMainThread:aSelector withObject:btn waitUntilDone:YES];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
        
    }else{
        self.navigationItem.rightBarButtonItem = item;
        
    }
    return btn;
}

- (void)CGY_handleActionBtn:(UIButton *)sender{
    if (self.blockObject) self.blockObject(sender,nil,0);
    
}

- (UIButton *)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(BlockObject)handler{
    self.blockObject = handler;
    
    UIButton * btn = nil;
    if (imageName) {
        btn = [UIButton buttonWithSize:CGSizeMake(32, 32) image_N:imageName image_H:nil imageEdgeInsets:UIEdgeInsetsZero];
    }else{
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40) title:title font:15 titleColor_N:nil titleColor_H:nil titleEdgeInsets:UIEdgeInsetsZero];
        
    }
    btn.tag = isLeft == YES ? kTAG_BTN_BackItem : kTAG_BTN_RightItem;
    
    btn.hidden = isHidden;
    //
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn.center = view.center;
    [view addSubview:btn];
    
    //父视图调用子视图方法参数
    [view addActionHandler:^(id obj, id item, NSInteger idx) {
        if (NSDate.date.timeIntervalSince1970 - self.timeInterval < 1) return;
        if (self.timeInterval > 0) self.timeInterval = NSDate.date.timeIntervalSince1970;
        
        [self performSelectorOnMainThread:@selector(CGY_handleActionBtn:) withObject:btn waitUntilDone:YES];

    }];
    
    //        [UIView getLayerView:view];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
        
    }else{
        self.navigationItem.rightBarButtonItem = item;
        
    }
    return btn;
}

//- (UIButton *)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(BlockObject)handler{
//
//    self.blockObject = handler;
//    if (!isLeft) {
//
//        if (imageName) {
//            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(0, 0, 30, 30);
//            btn.exclusiveTouch = YES;
//            UIImage * image = [UIImage imageNamed:imageName];
//            [btn setImage:image forState:UIControlStateNormal];
//            //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
//
//            btn.titleLabel.text = imageName;//执行点击动作时做判断条件
//            btn.tag = kTAG_BTN_RightItem;
//            btn.hidden = isHidden;
//            [btn addTarget:self action:@selector(CGY_handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
//            //
//            [self getLayView:btn];
//            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//            self.navigationItem.rightBarButtonItem = rightItem;
//            return btn;
//        }else{
//            CGSize titleSize = [self sizeWithText:title font:15 width:kScreen_width];
//            //            DDLog(@"size %@",NSStringFromCGSize(titleSize));
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            if (title.length <= 2) {
//                titleSize.width = 35;
//            }else{
//                btn.titleLabel.adjustsFontSizeToFitWidth = YES;
//                btn.titleLabel.minimumScaleFactor = 1;
//            }
//
//            btn.frame = CGRectMake(0, 0, titleSize.width, 30);
//            btn.titleEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
//            btn.exclusiveTouch = YES;
//
//            [btn setTitle:title forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//            btn.titleLabel.font = [UIFont systemFontOfSize:14];
//            if (title.length >= 3) btn.titleLabel.font = [UIFont systemFontOfSize:12];
//
//            //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
//            btn.tag = kTAG_BTN_RightItem;
//            btn.hidden = isHidden;
//
//            [btn addTarget:self action:@selector(CGY_handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
//            //
//            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//            self.navigationItem.rightBarButtonItem = rightItem;
//            return btn;
//
//        }
//    }
//    else{
//
//        if (self.navigationItem.leftBarButtonItem.tag == kTAG_BTN_BackItem) {
//            DDLog(@"!____已存在");
//            return (UIButton *)self.navigationItem.leftBarButtonItem;
//        }
//
//        if (imageName) {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(0, 0, 30, 30);
//            btn.exclusiveTouch = YES;
//            UIImage * image = [UIImage imageNamed:imageName];
//            [btn setImage:image forState:UIControlStateNormal];
//            //    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
//
//            btn.titleLabel.text = imageName;//执行点击动作时做判断条件
//            btn.tag = kTAG_BTN_BackItem;
//            btn.hidden = isHidden;
//            [btn addTarget:self action:@selector(CGY_handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
//            //
//            UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//            self.navigationItem.leftBarButtonItem = btnItem;
//            return btn;
//
//        }else{
//
//            if (!title) {
//                CGSize iconSize = CGSizeMake(18, 29);
//                iconSize = CGSizeMake(32, 32);
//
//                CGSize btnSize = CGSizeMake(30, 30);
//
//                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                btn.frame = CGRectMake(0, 0, btnSize.width, btnSize.height);
//                [btn setImage:[UIImage imageNamed:@"img_btnBack.png"] forState:UIControlStateNormal];
//                [btn setImageEdgeInsets:UIEdgeInsetsMake((btnSize.height - iconSize.height)/2.0, (btnSize.width - iconSize.width)/2.0, (btnSize.height - iconSize.height)/2.0, (btnSize.width - iconSize.width)/2.0)];
//
//                [btn addTarget:self action:@selector(CGY_handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
//                btn.tag = kTAG_BTN_BackItem;
//                btn.hidden = isHidden;
//                //
//                UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//                self.navigationItem.leftBarButtonItem = leftItem;
//                return btn;
//            }else{
//                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                btn.frame = CGRectMake(0, 0, 30, 30);
//                [btn setImage:nil forState :UIControlStateNormal];
//                [btn setTitle:title forState:UIControlStateNormal];
//                btn.titleLabel.font = [UIFont systemFontOfSize:14];
//                if (title.length >= 3) btn.titleLabel.font = [UIFont systemFontOfSize:12];
//
//                btn.tag = kTAG_BTN_BackItem;
//                btn.hidden = isHidden;
//                [btn addTarget:self action:@selector(CGY_handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
//                //
//                UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//                [btn addTarget:self action:@selector(CGY_handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
//                self.navigationItem.leftBarButtonItem = btnItem;
//                return btn;
//            }
//        }
//    }
//}

- (UITableViewCell *)getCellByClickView:(UIView *)view{
    UIView * supView = [view superview];
    while (![supView isKindOfClass:[UITableViewCell class]]) {
        
        supView = [supView superview];
    }
    UITableViewCell * tableViewCell = (UITableViewCell *)supView;
    return tableViewCell;
}

- (NSIndexPath *)getCellIndexPathByClickView:(UIView *)view  tableView:(UITableView *)tableView{
    UITableViewCell * cell = [self getCellByClickView:view];
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint:cell.center];
    return indexPath;
}

- (BOOL)isCurrentVisibleViewController{
    return (self.isViewLoaded && self.view.window);
}

- (void)goAgreementPageViewWithTitle:(NSString *)title URL:(NSString *)URL navController:(UINavigationController *)navController{
//
//    WHKTheAgreementViewController * viewController = [[WHKTheAgreementViewController alloc]init];
//    viewController.title = title;
//    viewController.agreementURL = URL;
//    [navController pushViewController:viewController animated:YES];
    
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (id)findController:(NSString *)contollerName controllers:(NSArray *)controllers{
    NSArray * arrayNew = [NSArray arrayWithArray:controllers];

    __block UIViewController * controller = nil;
    [arrayNew enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSClassFromString(contollerName) class]]) {

            controller = obj;
            *stop = YES;
        }
    }];
    return controller;

}

- (id)findController:(NSString *)contollerName navController:(UINavigationController *)navController{

    __block UIViewController * controller = nil;
    [navController.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSClassFromString(contollerName) class]]) {
            
            controller = obj;
            *stop = YES;
        }
    }];
    return controller;
    
}

- (void)goController:(NSString *)contollerName navController:(UINavigationController *)navController{
    
    if (!navController) {
//        navController = (UINavigationController *)[[[UIApplication sharedApplication]keyWindow]rootViewController];
        navController = self.currentVC.navigationController;
    }
    
    if ([self findController:contollerName controllers:navController.viewControllers]) {
        UIViewController * viewController = [self findController:contollerName controllers:navController.viewControllers];
        [navController popToViewController:viewController animated:YES];
    }
    else{
        UIViewController * viewController  = [NSClassFromString(contollerName) new];
        [navController pushViewController:viewController animated:YES];

    }
}

- (void)goController:(NSString *)contollerName{
    [self goController:contollerName navController:self.currentVC.navigationController];

}

- (UIViewController *)getController:(NSString *)contollerName navController:(UINavigationController *)navController{
    
    if (!navController) {
//        navController = (UINavigationController *)[[[UIApplication sharedApplication]keyWindow]rootViewController];
        navController = self.currentVC.navigationController;

    }
    
    UIViewController * viewController  = [NSClassFromString(contollerName) new];
    if ([self findController:contollerName controllers:navController.viewControllers]) {
        viewController = [self findController:contollerName controllers:navController.viewControllers];
    }
    return viewController;
}

- (UIViewController *)getController:(NSString *)contollerName{
    UIViewController * viewController = [self getController:contollerName navController:self.currentVC.navigationController];
  
    return viewController;
}

-(NSString *)controllerName{
    
    NSString * className = NSStringFromClass([self class]);
    if ([className containsString:@"Controller"]) {
        NSRange range = NSMakeRange(0, 0);
        if ([className rangeOfString:@"ViewController"].location != NSNotFound) {
            range = [className rangeOfString:@"ViewController"];
        }
        else if ([className rangeOfString:@"Controller"].location != NSNotFound){
            range = [className rangeOfString:@"Controller"];
        }
        className = [className substringToIndex:range.location];
    }
    return className;
}

//当前屏幕显示的viewcontroller
-(UIViewController *)currentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *controller = [self getCurrentVCFrom:rootViewController];
    
    return controller;
}

//查找Window当前显示的ViewController
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    }
    else {
        // 根视图为非导航类
        currentVC = rootVC;
        
    }
    return currentVC;
}


- (id _Nullable )frontViewController:(UINavigationController *_Nonnull)navContoller{

    UIViewController * viewController = nil;

    NSUInteger count = navContoller.viewControllers.count;
    if (count >= 2) {
        viewController = navContoller.viewControllers[count - 2];
    }
    else{
        viewController = self.rootVC;
        
    }
    self.frontController = viewController;//初始化
    return viewController;
    
}

- (NSString *_Nonnull)getCtrTypeWithCtrDict:(NSDictionary *_Nonnull)controllerDict frontCtr:(UIViewController *_Nullable)frontController{

    NSString * controllerType = @"0";
    if (frontController) {
        NSString * className = NSStringFromClass([frontController class]);
        if ([controllerDict.allKeys containsObject:className]) {
            controllerType = controllerDict[className];
            
        }
        else{
            controllerType = @"0";
            
        }
    }
    return controllerType;
}

#pragma make - - 系统Alert封装方法

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg blockAction:(BlockAlertController _Nullable)blockAction{
    
    if (self.blockAlertController != blockAction) {
        self.blockAlertController = blockAction;
        
    }
    kWeakSelf(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell
                                                        style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action){
                                                          kStrongSelf(weakself);
                                                          if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Sure
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
                                                          kStrongSelf(weakself);
                                                          if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);

                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList blockAction:(BlockAlertController _Nullable)blockAction{
    
    if (self.blockAlertController != blockAction) self.blockAlertController = blockAction;
    kWeakSelf(self);

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList firstObject]
                                                        style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action){
//                                                          self.blockAlertController(action);
                                                          kStrongSelf(weakself);
                                                          strongSelf.blockAlertController(alertController,action);

                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList lastObject]
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
//                                                          self.blockAlertController(action);
                                                          kStrongSelf(weakself);
                                                          strongSelf.blockAlertController(alertController,action);

                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title placeholder:(NSString *)placeholder actionTitleList:(NSArray *_Nonnull)actionTitleList blockAction:(BlockAlertController _Nullable)blockAlertController{
    
    if (self.blockAlertController!= blockAlertController) self.blockAlertController = blockAlertController;
        
    kWeakSelf(self);
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        textField.textAlignment = NSTextAlignmentCenter;
        
    }];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList firstObject] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        kStrongSelf(weakself);
        if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);

    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList lastObject] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        kStrongSelf(weakself);
        if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);

    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showSheetWithTitle:(nullable NSString *)title msgList:(NSArray * _Nonnull)msgList blockAction:(BlockAlertController _Nullable)blockAction{
    if (self.blockAlertController != blockAction) self.blockAlertController = blockAction;
        
    kWeakSelf(self);
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i < msgList.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:msgList[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            kStrongSelf(weakself);
            if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        kStrongSelf(weakself);
        if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);

    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg{

    kWeakSelf(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Sure
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action){
                                                kStrongSelf(weakself);
                                                if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
                                                
                                            }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showAlertWithMsg:(NSString *)msg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [self presentViewController:alertController animated:YES completion:^{
        [self performSelector:@selector(alertdismiss:) withObject:alertController afterDelay:kAnimationDuration_Toast];

    }];

}

- (void)alertdismiss:(UIAlertController *)alertController{
    [alertController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark -------------alert升级方法-------------------
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg handler:(BlockAlertController _Nullable)handler{
    [self showAlertWithTitle:title placeholderList:nil msg:msg actionTitleList:@[kActionTitle_Cancell,kActionTitle_Sure] handler:handler];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(BlockAlertController _Nullable)handler{
    [self showAlertWithTitle:title placeholderList:nil msg:msg actionTitleList:actionTitleList handler:handler];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title placeholderList:(NSArray *)placeholderList msg:(NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(BlockAlertController _Nullable)handler{
    
    self.blockAlertController = handler;
    kWeakSelf(self);

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (NSString * placeholder in placeholderList) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            textField.textAlignment = NSTextAlignmentCenter;
            
        }];
    }
    
    
    switch (actionTitleList.count) {
        case 0:
        {
            [self presentViewController:alertController animated:YES completion:^{
                [self performSelector:@selector(alertdismiss:) withObject:alertController afterDelay:kAnimationDuration_Toast];
                
            }];
        }
            break;
        case 1:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList firstObject]
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action){
                                                                  kStrongSelf(weakself);
                                                                  if (strongSelf.blockAlertController) if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
                                                                  

                                                              }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        case 2:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList firstObject] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                kStrongSelf(weakself);
                if (strongSelf.blockAlertController) if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList lastObject] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                kStrongSelf(weakself);
                if (strongSelf.blockAlertController) if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        default:
        {
            for (NSInteger i = 0; i < actionTitleList.count; i++) {
                [alertController addAction:[UIAlertAction actionWithTitle:actionTitleList[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    kStrongSelf(weakself);
                    if (strongSelf.blockAlertController) if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
                }]];
            }
            [self presentViewController:alertController animated:YES completion:nil];

        }
            break;
    }
}

- (void)showSheetWithTitle:(nullable NSString *)title msgList:(NSArray * _Nonnull)msgList handler:(BlockAlertController _Nullable)handler{
    if (self.blockAlertController != handler) self.blockAlertController = handler;
    
    kWeakSelf(self);
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i < msgList.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:msgList[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            kStrongSelf(weakself);
            if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        kStrongSelf(weakself);
        if (strongSelf.blockAlertController) strongSelf.blockAlertController(alertController,action);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark -------------alert升级方法-------------------

- (void)dispalyAppEvalutionStarLevelAppID:(NSString *)appID{
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
        [[UIApplication sharedApplication].keyWindow endEditing:YES];//防止键盘遮挡
        [SKStoreReviewController requestReview];
        
    }
    else{
        NSString *reviewURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",appID];
        if (iOS(11)) {
            reviewURL = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",appID];//替换为对应的APPID
        }
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appEvaluationUrl]];
        
        NSDictionary * options = @{
                                   UIApplicationOpenURLOptionUniversalLinksOnly : @YES
                                   };
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL] options:options completionHandler:^(BOOL success) {
            
        }];
    }
}

//- (void)pushToRichTextDisplayType:(NSString *)type title:(NSString *)title{
//    WHKRichTextDisplayViewController * viewController = [[WHKRichTextDisplayViewController alloc] init];
//    viewController.type = type;
//    viewController.title = title;
//    [self.currentVC.navigationController pushViewController:viewController animated:YES];
//
//}
//
//- (void)showToastHud:(NSString *)msg inView:(UIView *)inView{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD showToastWithTips:msg inView:inView];
//
//    });
//}
//
//- (void)hiddenToastHud:(MBProgressHUD *)hud afterDelay:(NSTimeInterval)delay{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [hud hideAnimated:YES afterDelay:delay];
//
//    });
//}


- (id)getTextFieldRightView:(NSString *)unitString{
    //    NSArray * unitList = @[@"元",@"公斤"];
    if (unitString != nil && ![unitString isEqualToString:@""]) {
        if ([unitString containsString:@"png"] && [unitString containsString:@"."]) {
            CGSize size = CGSizeMake(20, 20);
            UIImageView * imgView = [UIImageView createImageViewWithRect:CGRectMake(0, 0, size.width, size.height) image:unitString tag:kTAG_IMGVIEW patternType:@"0"];
            return imgView;
        }
        else{
            CGSize size = [self sizeWithText:unitString font:@(KFZ_Third) width:kScreen_width];
            
            UILabel * label = [UILabel createLabelWithRect:CGRectMake(0, 0, size.width+2, 25) text:unitString textColor:kC_TextColor_Title tag:kTAG_LABEL patternType:@"2" font:KFZ_Third backgroudColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
            return label;
        }
    }
    return nil;
}

- (void)callPhone:(NSString *)phoneNumber{
    
    NSArray * titleList = @[@"取消",@"呼叫"];
    [self showAlertWithTitle:nil msg:phoneNumber actionTitleList:titleList handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action) {
        if ([action.title isEqualToString:[titleList lastObject]]) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString * phoneStr = [NSString stringWithFormat:@"tel:%@",phoneNumber];
                if (iOS(10)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr] options:@{} completionHandler:nil];
                    
                }else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
                    
                }
            });
        }
    }];

}


- (void)showFriendAdd:(NSString *)msg{
    
    [self showAlertWithTitle:@"发送成功" msg:msg actionTitleList:@[kActionTitle_Sure] handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action) {
        if ([action.title isEqualToString:kActionTitle_Sure]) {
            
        }
    }];

}


@end













