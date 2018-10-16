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
NSMutableDictionary *threadDic = [[NSThread currentThread] threadDictionary];\
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


#define kAdd_By_BIN //add by BIN


//颜色
#define kC_TextColor [UIColor colorWithHexString:@"#333333"]
#define kC_TextColor_Title [UIColor colorWithHexString:@"#666666"]
#define kC_TextColor_TitleSub [UIColor colorWithHexString:@"#999999"]
//主题色

//绿色
//#define UIColor.themeColor_One [UIColor colorWithHexString:@"#25b195"]
//水蓝色
//#define UIColor.themeColor [UIColor colorWithHexString:@"#29b4f5"]

#define kC_BlueColor    kCOLOR_RGBA(63, 153,231,1)

#define kPageSize 20
//图片最大尺寸500k
#define kFileSize_image 1*1024*1024

//强弱引用
#define kWeakSelf(type)    __weak __typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong __typeof(type) strongSelf = type;

//强弱引用(进化)
#define kWeakObj(type)    __weak __typeof(type) weak##type = type;
#define kStrongObj(type)  __strong __typeof(type) strong##type = type;


#define kPlistFilePath  @"/Library/File_Plist/"

//plist文件名
#define kPlistName_common               @"HuiZhuBang_common.plist"
#define kPlistKey_vehicleTypeDict       @"key_vehicleTypeDict"
#define kPlistKey_vehicleTypeArr        @"key_vehicleTypeArr"
#define kPlistKey_vehicleTypeIconArr    @"key_vehicleTypeIconArr"


/*--------------------------------MacroGeometry------------------------------------------------------*/
#pragma mark - -MacroGeometry与计算有关的尺寸属性


//屏幕 rect
#define kScreen_rect    (UIScreen.mainScreen.bounds)

#define kScreen_width  (UIScreen.mainScreen.bounds.size.width)
#define kScreen_height (UIScreen.mainScreen.bounds.size.height)


//屏幕scale
#define kScale_Screen  (UIScreen.mainScreen.scale)
//屏幕分辨率
#define kSreenResolution (kScreen_width * kScreen_height * kScale_Screen)

//由角度转换弧度 由弧度转换角度
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)

#define kMenuViewSize  CGSizeMake(kScreen_width*3/4, kScreen_height)
#define kMenuViewRatio (3/4.0)

#define kS_scaleOrder  0.7

#define kH_CellHeight_single 50

#define kH_FilterView 45
#define kH_CellHeight_Filter 40

#define kX_GAP_BTN  20
#define kH_BtnView  40

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


#endif /* BN_Marco_h */
