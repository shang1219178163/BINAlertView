//
//  MacroUtilities.h
//  HuiZhuBang
//
//  Created by 晁进 on 17-7-25.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#ifndef HuiZhuBang_MacroUtilities_h
#define HuiZhuBang_MacroUtilities_h

#pragma mark - -MacroUtilities通用

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

#define kKeyWindow ([UIApplication sharedApplication].keyWindow)

#define kRootVC   ([UIApplication sharedApplication].keyWindow.rootViewController)

//颜色
#define kC_TextColor [UIColor colorWithHexString:@"#333333"]
#define kC_TextColor_Title [UIColor colorWithHexString:@"#666666"]
#define kC_TextColor_TitleSub [UIColor colorWithHexString:@"#999999"]
//主题色
//#define kC_ThemeCOLOR [UIColor colorWithHexString:@"#29b4f5"]
#define kC_ThemeCOLOR [UIColor colorWithHexString:@"#0082e0"]

//#define kC_BackgroudColor [UIColor colorWithHexString:@"#f8f8f8"]
#define kC_BackgroudColor [UIColor colorWithHexString:@"#E9E9E9"]//233,233,233


#define kC_LineColor [UIColor colorWithHexString:@"#e0e0e0"]

//绿色
#define kC_ThemeCOLOR_One [UIColor colorWithHexString:@"#25b195"]
//水蓝色
#define kC_ThemeCOLOR_Two [UIColor colorWithHexString:@"#29b4f5"]


#define kC_BtnColor_N [UIColor colorWithHexString:@"#fea914"]
#define kC_BtnColor_H [UIColor colorWithHexString:@"#f1a013"]
#define kC_BtnColor_D [UIColor colorWithHexString:@"#999999"]

#define kC_BlueColor    kCOLOR_RGBA(63, 153,231,1)

#define kPageSize 20
//图片最大尺寸500k
#define kFileSize_image 1*1024*1024

//button背景
#define kIMG_btnImage [UIImage imageWithColor:[UIColor colorWithHexString:@"#228ce2"]]
#define kIMG_btnImage_Highlight [UIImage imageWithColor:[UIColor colorWithHexString:@"#1774c0"]]

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

//强弱引用
#define kWeakSelf(type)    __weak __typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong __typeof(type) strongSelf = type;

//强弱引用(进化)
#define kWeakObj(type)    __weak __typeof(type) weak##type = type;
#define kStrongObj(type)  __strong __typeof(type) strong##type = type;

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()

//keyWindow
#define kKeyWindow  ([UIApplication sharedApplication].keyWindow)

#define kPlistFilePath  @"/Library/File_Plist/"

//plist文件名
#define kPlistName_common               @"HuiZhuBang_common.plist"
#define kPlistKey_vehicleTypeDict       @"key_vehicleTypeDict"
#define kPlistKey_vehicleTypeArr        @"key_vehicleTypeArr"
#define kPlistKey_vehicleTypeIconArr    @"key_vehicleTypeIconArr"


#define kNIl_TEXT @"--"

/*--------------------------------MacroGeometry------------------------------------------------------*/
#pragma mark - -MacroGeometry与计算有关的尺寸属性

#define kH_StatusBarHeight 20
//NavBar高度
#define kH_NaviagtionBarHeight 44
//TabBar高度
#define kH_TabBarHeight 49

//#define kH_StatusBarHeight          CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])
//#define kH_NaviagtionBarHeight      CGRectGetHeight(self.navigationController.navigationBar.frame)

//状态栏 ＋ 导航栏 高度
#define kH_StatusAndNaviagtionBarHeight  ((kH_StatusBarHeight) + (kH_NaviagtionBarHeight))

//屏幕 rect
#define kScreen_rect    ([UIScreen mainScreen].bounds)

#define kScreen_width  ([UIScreen mainScreen].bounds.size.width)
#define kScreen_height ([UIScreen mainScreen].bounds.size.height)

#define kH_CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

//屏幕scale
#define kScale_Screen  ([UIScreen mainScreen].scale)
//屏幕分辨率
#define kSreenResolution (kScreen_width * kScreen_height * kScale_Screen)

//由角度转换弧度 由弧度转换角度
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)

#define kMenuViewSize  CGSizeMake(kScreen_width*3/4, kScreen_height)
#define kMenuViewRatio (3/4.0)

#define kLeftMenuRatio  0.8

#define kS_scaleOrder  0.7

#define kH_SegmentOfCustom  50
#define kH_SegmentControl  44
#define kH_TopView  50

#define kH_searchBar  36
#define kH_searchBarBackgroud  56

//#define kH_CellHeight 60
#define kH_CellHeight_single 50

#define kH_FilterView 45
#define kH_CellHeight_Filter 40

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


#endif
