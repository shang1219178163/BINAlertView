//
//  Utilities.h
//  HuiZhuBang
//
//  Created by 晁进 on 17-7-25.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

/**
 *  获取单例
 */
+ (instancetype)sharedInstance;


+ (NSString *)getApp_Name;
+ (UIImage  *)getApp_Icon;

+ (NSString *)getApp_Version;
+ (NSString *)getApp_build;
+ (NSString *)getPhone_SystemVersion;
+ (NSString *)getPhone_SystemName;
+ (NSString *)getPhone_Name;
+ (NSString *)getPhone_Model;
+ (NSString *)getPhone_localizedModel;
    
//plist文件读取数据
+ (id)readBoundleDataWithKey:(NSString *)key plistFileName:(NSString *)fileName;
//plist文件写入数据
+ (BOOL)writeData:(id)data plistKey:(NSString *)plistKey plistFileName:(NSString *)fileName;
+ (id)readDataWithKey:(NSString *)key plistFileName:(NSString *)fileName;

+ (NSString *)encodeTheString:(NSString *)inputString;

+ (NSString *)AESEncryptTheString:(NSString *)inputString;

+ (NSString *)AESDencryptTheString:(NSString *)inputString;


+ (NSString *)encrypt:(NSString *)message password:(NSString *)password;

+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password;


/**
 接口集合加密

 @param parameters jsonString
 @param collection 接口集合
 @return 加密jsonString
 */
- (id)AES128_EncryptParameters:(id)parameters collection:(id)collection;

/**
 集合接口解密

 @param parameters jsonString
 @param collection 接口集合
 @param obj responseObject接口返回数据
 @return 解密responseObject
 */
- (id)AES128_DecryptParameters:(id)parameters collection:(id)collection obj:(id)obj;
    
//控制器跳转原生动画
+ (void)animationViewContoller:(NSString *)animationType;

+ (void)restoreRootViewController:(UIViewController *)rootViewController;




@end


