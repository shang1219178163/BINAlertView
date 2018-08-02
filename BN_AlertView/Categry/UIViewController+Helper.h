//
//  UIViewController+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FailRefreshViewDelegate<NSObject>

@optional
- (void)failRefresh;

@end


typedef void(^BlockAlertController)(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action);

@interface UIViewController (Helper)

-(BOOL)isCurrentVisibleViewController;

- (void)addFailRefreshViewWithTitle:(NSString *_Nonnull)title;
- (void)addNoDataRefreshViewWithTitle:(NSString *)title;

//- (void)addFailRefreshView;
- (void)removeFailRefreshView;

@property (nonatomic, weak) id<FailRefreshViewDelegate> delegate;

@property (nonatomic, copy) BlockAlertController _Nullable blockAlertController;

@property (nonatomic, strong) UIViewController * _Nullable frontController;//(弃用)
@property (nonatomic, strong) UIViewController * _Nullable frontVC;

@property (nonatomic, strong, readonly) NSString * _Nullable controllerName;
@property (nonatomic, strong, readonly) UIViewController * _Nullable currentVC;

@property (nonatomic, strong) NSDictionary * _Nonnull controllerDict;//(弃用)
@property (nonatomic, strong) NSString * _Nonnull controllerType;//(弃用)

@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
  导航栏按钮
 */
- (UIButton *_Nonnull)createBarBtnItemWithTitle:(NSString *_Nullable)title imageName:(NSString *_Nullable)imageName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(BlockObject _Nullable )handler;

//- (void)addLineViewWithRect:(CGRect)rect inView:(UIView *_Nonnull)inView;
//- (void)addLineDashWithRect:(CGRect)rect tag:(NSInteger)tag inView:(UIView *_Nonnull)inView;

- (UITableViewCell *_Nonnull)getCellByClickView:(UIView *_Nonnull)view;

- (NSIndexPath *_Nonnull)getCellIndexPathByClickView:(UIView *_Nonnull)view tableView:(UITableView *_Nonnull)tableView;

- (void)goAgreementPageViewWithTitle:(NSString *_Nullable)title URL:(NSString *_Nonnull)URL navController:(UINavigationController *_Nonnull)navController;

/**
 找导航控制器栈中控制器
 */
- (id _Nullable )findController:(NSString *_Nonnull)contollerName navController:(UINavigationController *_Nonnull)navController;


- (void)goController:(NSString *_Nonnull)contollerName;

/**
 跳转到contollerName控制器中去,先在navController栈中查找有就返回没有就创建一个(用于无参数跳转界面)

 @param contollerName 控制器名称
 @param navController 导航控制器
 */
- (void)goController:(NSString *_Nonnull)contollerName navController:(UINavigationController *_Nullable)navController;


/**
 堆栈中查找控制器,找到返回,没有创建
 */
- (UIViewController *_Nonnull)getController:(NSString *_Nonnull)contollerName navController:(UINavigationController *_Nullable)navController;

- (UIViewController *_Nullable)getController:(NSString *_Nonnull)contollerName;

/**
 系统弹窗__按钮默认(取消,确认)
 */
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg handler:(BlockAlertController _Nullable)handler;

/**
 系统弹窗__按钮自定义(actionTitleList传入按钮标题)
 */
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(BlockAlertController _Nullable)handler;

/**
 弹窗源方法
 placeholderList或者 msg  其中一个必须为nil
 */
- (void)showAlertWithTitle:(nullable NSString *)title placeholderList:(NSArray *_Nullable)placeholderList msg:(NSString *_Nullable)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(BlockAlertController _Nullable)handler;

- (void)alertdismiss:(UIAlertController *_Nonnull)alertController;

/**
 系统Sheet弹窗__按钮默认(取消按钮)
 */
- (void)showSheetWithTitle:(nullable NSString *)title msgList:(NSArray * _Nonnull)msgList handler:(BlockAlertController _Nullable)handler;

//app星际评价,自定义app链接
- (void)dispalyAppEvalutionStarLevelAppID:(NSString *_Nonnull)appID;

- (void)showToastHud:(NSString *_Nullable)msg inView:(UIView *_Nullable)inView;


/**
 法律条款/合作协议
 */
- (void)pushToRichTextDisplayType:(NSString *)type title:(NSString *)title;

//- (void)hiddenToastHud:(MBProgressHUD *_Nonnull)hud afterDelay:(NSTimeInterval)delay;

/**
 textfield的rightView

 @param unitString 图片名称或者字符串
 @return UIImageView或者UILabel
 */
- (id _Nullable )getTextFieldRightView:(NSString *_Nonnull)unitString;

//- (BOOL)checkLogin;

- (void)callPhone:(NSString *_Nonnull)phoneNumber;


/**
 添加好友弹窗
 */
- (void)showFriendAdd:(NSString *_Nonnull)msg;

@end
