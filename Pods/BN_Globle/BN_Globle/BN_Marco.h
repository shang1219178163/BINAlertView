//
//  BN_Marco.h
//  ProductTemplet
//
//  Created by hsf on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef BN_Marco_h
#define BN_Marco_h

#pragma mark - -BN_Marco通用

#ifdef DEBUG
//#define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define DDLog(FORMAT, ...) {\
NSString *formatStr = @"yyyy-MM-dd HH:mm:ss.SSSSSSZ";\
NSMutableDictionary *threadDic = NSThread.currentThread.threadDictionary;\
NSDateFormatter *formatter = [threadDic objectForKey:formatStr];\
if (!formatter) {\
formatter = [[NSDateFormatter alloc]init];\
formatter.dateFormat = formatStr;\
formatter.locale = [NSLocale currentLocale];\
formatter.timeZone = [NSTimeZone systemTimeZone];\
[threadDic setObject:formatter forKey:formatStr];\
}\
NSString *str = [formatter stringFromDate:[NSDate date]];\
fprintf(stderr,"%s【line -%d】%s %s\n",[str UTF8String], __LINE__,__PRETTY_FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}

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


/*--------------------------------MacroGeometry------------------------------------------------------*/
#pragma mark - -MacroGeometry与计算有关的尺寸属性

//屏幕 rect
#define kScreenWidth  (UIScreen.mainScreen.bounds.size.width)
#define kScreenHeight (UIScreen.mainScreen.bounds.size.height)


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
[scrollView performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
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

/**
 YYKit
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#endif /* BN_Marco_h */
