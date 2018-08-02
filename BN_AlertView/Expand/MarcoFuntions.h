//
//  MarcoFuntions.h
//  BINAlertView
//
//  Created by hsf on 2018/3/1.
//  Copyright © 2018年 hsf. All rights reserved.
//

#ifndef MarcoFuntions_h
#define MarcoFuntions_h

#ifdef DEBUG
#define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DDLog(...)
#endif


#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif


#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#pragma mark- -others其他


#define dispatch_main_sync_safe(block)                    \
if ([NSThread isMainThread]) {                        \
block();                                          \
} else {                                              \
dispatch_sync(dispatch_get_main_queue(), block);  \
}

#define dispatch_main_async_safe(block)                   \
if ([NSThread isMainThread]) {                        \
block();                                          \
} else {                                              \
dispatch_async(dispatch_get_main_queue(), block); \
}


#define  kAdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


////设置加载提示框（第三方框架：Toast）
//#define LRToast(str)  CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
//[keyWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
//keyWindow.userInteractionEnabled = NO; \
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
//keyWindow.userInteractionEnabled = YES;\
//});


//// 加载
//#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
//// 收起加载
//#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
//// 设置加载
//#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
//#define kBackView         for (UIView *item in keyWindow.subviews) { \
//if(item.tag == 10000) \
//{ \
//[item removeFromSuperview]; \
//UIView * aView = [[UIView alloc] init]; \
//aView.frame = [UIScreen mainScreen].bounds; \
//aView.tag = 10000; \
//aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
//[keyWindow addSubview:aView]; \
//} \
//} \
//
//#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:keyWindow animated:YES];kShowNetworkActivityIndicator()
//#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:keyWindow animated:YES]
//#define kRemoveBackView         for (UIView *item in keyWindow.subviews) { \
//if(item.tag == 10000) \
//{ \
//[UIView animateWithDuration:0.4 animations:^{ \
//item.alpha = 0.0; \
//} completion:^(BOOL finished) { \
//[item removeFromSuperview]; \
//}]; \
//} \
//} \


#endif /* MarcoFuntions_h */
