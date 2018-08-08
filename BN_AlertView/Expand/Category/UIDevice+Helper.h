//
//  UIDevice+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Helper)

+(NSString *)app_Name;
+(NSString *)app_Icon;
+(NSString *)app_Version;
+(NSString *)app_build;
+(NSString *)phone_SystemVersion;
+(NSString *)phone_SystemName;
+(NSString *)phone_Name;
+(NSString *)phone_Model;
+(NSString *)phone_localizedModel;

- (NSString *)uniqueDeviceIdentifier;

- (NSString *)uniqueGlobalDeviceIdentifier;

- (NSString *)platformString;

    
@end
