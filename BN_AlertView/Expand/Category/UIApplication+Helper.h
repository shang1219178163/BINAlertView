//
//  UIApplication+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import <JPUSHService.h>
//#import <AdSupport/AdSupport.h>

#define kJPushKey_type          @"into_page_type"
#define kJPushKey_extras        @"extras"

@interface UIApplication (Helper)

//@property (nonatomic, strong) UIViewController * rootVC;
//@property (nonatomic, strong, readonly) UIWindow * keyWindow;

//@property (nonatomic, strong, readonly) NSString * app_Name;
//@property (nonatomic, strong, readonly) NSString * app_Icon;
//@property (nonatomic, strong, readonly) NSString * app_Version;
//@property (nonatomic, strong, readonly) NSString * app_build;
//@property (nonatomic, strong, readonly) NSString * phone_SystemVersion;
//@property (nonatomic, strong, readonly) NSString * phone_SystemName;
//@property (nonatomic, strong, readonly) NSString * phone_Name;
//@property (nonatomic, strong, readonly) NSString * phone_Model;
//@property (nonatomic, strong, readonly) NSString * phone_localizedModel;

+ (void)setupRootControllerName:(NSString *)controllerName;

+ (void)setupAppearance;

+ (void)setupNavigationbar;

+ (void)setupIQKeyboardManager;

+ (void)registerUMengSDKAppKey:(NSString *)appKey channel:(NSString *)channel;

/**
 * 初始化JPushSDK
 */
//+ (void)registerJPushSDKAppKey:(NSString *)appKey channel:(NSString *)channel isProduction:(BOOL)isProduction options:(NSDictionary *)launchOptions;

+ (void)setupTabBarSelectedIndex:(NSUInteger)selectedIndex;

@end
