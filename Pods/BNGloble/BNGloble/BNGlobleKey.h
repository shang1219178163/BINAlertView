//
//  BNGlobleKey.h
//  ProductTemplet
//
//  Created by hsf on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef BNGlobleKey_h
#define BNGlobleKey_h

/**
 协议条款网址
 */
#define kString_AgreementURL = @"";


#define kID_AppStoreConnect     @""

#pragma mark - -极光

#define kAppKey_JPush           @""
#define kAppSecret_JPush        @""

#define kChannel_JPush          @"App Store"

#ifdef DEBUG
#define kIsProduction           NO
#else
#define kIsProduction           YES
#endif


#pragma mark - -友盟

#define kAppKey_UMeng           @""
#define kChannel_UMeng          @"App Store"

#pragma mark - -地图


#define kMap_GDMapKey           @""


#pragma mark - -支付宝支付

/**
 -----------------------------------
 支付宝支付需要配置的参数
 -----------------------------------
 */

//开放平台登录https://openhome.alipay.com/platform/appManage.htm
//管理中心获取APPID
#define kAPPID_Ali              @""
//合作伙伴身份ID(partnerID)
#define kPID_Ali                @""

//应用注册scheme,在AliSDKDemo-Info.plist定义URL types
#define kPay_URLScheme_Ali      @"com.payAli.iOSClient"

/*===============================================================================================*/

#pragma mark - -微信支付

/**
 注意:支付单位为分
 
 */

#define kAppID_WX               @""
#define kAppKey_WX              @""

#define kAppID_QQ               @""
#define kAppKey_QQ              @""


#pragma mark - - RecognizeCard

/**
 身份证识别
 */
#define kRecognizeCard_AppKey      @"";
#define kRecognizeCard_AppSecret   @"";
#define kRecognizeCard_AppCode     @"";


#endif /* BNGlobleKey_h */
