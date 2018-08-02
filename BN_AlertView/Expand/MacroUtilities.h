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


#define kAdd_By_BIN //add by BIN

#define kKeyWindow ([UIApplication sharedApplication].keyWindow)

#define kRootVC   ([UIApplication sharedApplication].keyWindow.rootViewController)

// 获取RGB颜色
#define kCOLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kCOLOR_RGB(r,g,b) kRGBA(r,g,b,1.0f)
#define kCOLOR_dim [UIColor colorWithWhite:0.2f alpha: 0.5];////white 0-1为黑到白,alpha透明度

#define kCOLOR_RGB_Init(r,g,b,a) [[UIColor alloc]initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];

// 十六进制颜色
#define kCOLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

//颜色
#define kC_TextColor [UIColor colorWithHexString:@"#333333"]
#define kC_TextColor_Title [UIColor colorWithHexString:@"#666666"]
#define kC_TextColor_TitleSub [UIColor colorWithHexString:@"#999999"]
//橘色
#define kC_ThemeCOLOR [UIColor colorWithHexString:@"#fea914"]
#define kC_BackgroudColor [UIColor colorWithHexString:@"#f8f8f8"]
//#define kC_BackgroudColor [UIColor lightTextColor]

//#define kC_LineColor [UIColor colorWithHexString:@"#e0e0e0"]
#define kC_LineColor [UIColor redColor]

#define kC_RandomColor [UIColor colorWithHue:(arc4random() % 256 / 256.0)  \
            saturation:(arc4random() % 128 / 256.0) + 0.5  \
           brightness:(arc4random() % 128 / 256.0) + 0.5  \
                alpha:1];
//绿色
#define kC_ThemeCOLOR_One [UIColor colorWithHexString:@"#25b195"]
//水蓝色
#define kC_ThemeCOLOR_Two [UIColor colorWithHexString:@"#29b4f5"]


#define kC_BtnColor_N [UIColor colorWithHexString:@"#fea914"]
#define kC_BtnColor_H [UIColor colorWithHexString:@"#f1a013"]
#define kC_BtnColor_D [UIColor colorWithHexString:@"#999999"]

//#define kC_MARK_COLOR [UIColor colorWithHexString:@"#f35f39"]

//图片最大尺寸500k
#define kFileSize_image 1*1024*1024

#define kPageSize 20

//button背景
#define kIMG_btnImage [UIImage imageWithColor:[UIColor colorWithHexString:@"#228ce2"]]
#define kIMG_btnImage_Highlight [UIImage imageWithColor:[UIColor colorWithHexString:@"#1774c0"]]

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

//强弱引用
#define kWeakSelf(type)    __weak __typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong __typeof(type) strongSelf = type;

//强弱引用(进化)
//#define kWeakObjc(type)    __weak __typeof(type) weak##type = type;
//#define kStrongObjc(type)  __strong __typeof(type) strong##type = type;

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()

//系统版本判断
#define iOS(version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= version)?1:0)

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

#define kH_SegmentOfCustomeHeight  60

#endif
