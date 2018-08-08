//
//  Utilities.m
//  HuiZhuBang
//
//  Created by 晁进 on 17-7-25.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#import "Utilities.h"

#import "AppDelegate.h"

#import "Utilities_DM.h"

#import "NSData+Convert.h"
#import "NSString+Convert.h"

#import "NSString+AESCrypt.h"

static NSString *const kACSEncrypt = @"mbqh1Gtpj9L8pJuv";

@interface Utilities ()

@property(nonatomic, strong) NSDictionary * infoDict;

@end

@implementation Utilities

+ (Utilities *)sharedInstance{
    static Utilities * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Utilities alloc]init];
        
    });
    return instance;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static Utilities *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

-(NSDictionary *)infoDict{
    if (!_infoDict) {
        _infoDict = [[NSBundle mainBundle] infoDictionary];
        
    }
    return _infoDict;
}

+ (NSString *)getApp_Name{
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *infoDict = [[self sharedInstance]infoDict];
    return  [infoDict objectForKey:@"CFBundleDisplayName"];
    
}

/**
 在判断版本是否需要更新时，一定要用CFBundleShortVersionString。
 */
+ (NSString *)getApp_Version{
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *infoDict = [[self sharedInstance]infoDict];
    return  [infoDict objectForKey:@"CFBundleShortVersionString"];
    
}

+ (NSString *)getApp_build{
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *infoDict = [[self sharedInstance]infoDict];
    return  [infoDict objectForKey:@"CFBundleVersion"];
    
}

+ (UIImage *)getApp_Icon{
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *infoDict = [[self sharedInstance]infoDict];
    NSString *icon = [[infoDict valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    
    UIImage * image = [UIImage imageNamed:icon];
    return image;
}

+ (NSString *)getPhone_SystemVersion{
    return  [[UIDevice currentDevice] systemVersion];

}

+ (NSString *)getPhone_SystemName{
    return  [[UIDevice currentDevice] systemName];
    
}

+ (NSString *)getPhone_Name{
    return  [[UIDevice currentDevice] name];
    
}

+ (NSString *)getPhone_Model{
    return  [[UIDevice currentDevice] model];
    
}

+ (NSString *)getPhone_localizedModel{
    return  [[UIDevice currentDevice] localizedModel];
    
}

+ (id)readBoundleDataWithKey:(NSString *)key plistFileName:(NSString *)fileName
{
    NSArray * array = [fileName componentsSeparatedByString:@"."];
    NSString *path = [[NSBundle mainBundle] pathForResource:array[0] ofType:array[1]];// 找到plist文件
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];// 获取文件列表
    
    id obj = dict[key];
    return obj;
}

//sandBox
+ (id)readDataWithKey:(NSString *)key plistFileName:(NSString *)fileName
{
//    NSString * plistPath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/File_Plist/%@",fileName];
    NSString * filePath = [NSHomeDirectory() stringByAppendingFormat:@"%@%@",kPlistFilePath,fileName];
    NSMutableDictionary  *mdict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    id obj = mdict[key];
    return obj;
}

+ (BOOL)writeData:(id)data plistKey:(NSString *)plistKey plistFileName:(NSString *)fileName
{
//    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    DDLog(@"%@", paths[0]);

    //    NSString * plistPath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/File_Plist/%@",fileName];
    NSString * plistPath = [NSHomeDirectory() stringByAppendingFormat:@"%@",kPlistFilePath];
    if (![Utilities_DM fileExistAtPath:plistPath]) {
        [Utilities_DM createDirectoryAtPath:plistPath];
    }
    NSString *filePath = [plistPath stringByAppendingPathComponent:kPlistName_common];
//    DDLog(@"%@\n", filePath);

    NSMutableDictionary  *mdict = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([Utilities_DM fileExistAtPath:plistPath]) {
        mdict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        if (!mdict) {
            mdict = [NSMutableDictionary dictionaryWithCapacity:0];

        }
    }

    [mdict setSafeObjct:data forKey:plistKey];
   
    NSError * error = nil;
//    DDLog(@"data___%@",data);
    //    BOOL isSuccess = [data writeToFile:filePath atomically:YES encoding:nil error:&error];
    //    if (!isSuccess) {
    //        DDLog(@"isFail");
    //        DDLog(@"error__%@",error);
    //        return NO;//写入失败
    //
    //    }else{
    //        DDLog(@"isSuccess");
    //
    //        return YES;//写入成功
    //
    //    }
    BOOL isSuccess = [mdict writeToFile:filePath atomically:YES];
    if (isSuccess) {
        DDLog(@"isSuccess");
        
    }else{
        DDLog(@"isFail");
        
    }
    
    return isSuccess;
}

//+ (BOOL)writeData:(id)data plistFileName:(NSString *)fileName
//{
//    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    DDLog(@"%@", paths[0]);
//
////    NSString * plistPath = [NSHomeDirectory() stringByAppendingFormat:@"/Library/File_Plist/%@",fileName];
//    NSString * plistPath = [NSHomeDirectory() stringByAppendingFormat:@"%@",kPlistFilePath];
//    if (![Utilities_DM fileExistAtPath:plistPath]) {
//        [Utilities_DM createDirectoryAtPath:plistPath];
//    }
//    NSString *filePath = [plistPath stringByAppendingPathComponent:kPlistName_common];
//    
//    if (![Utilities_DM fileExistAtPath:filePath]) {
//        [Utilities_DM createDirectoryAtPath:filePath];
//        
//    }else{
//        DDLog(@"文件已存在");
//        
//    }
//    NSError * error = nil;
//    DDLog(@"data___%@",data);
////    BOOL isSuccess = [data writeToFile:filePath atomically:YES encoding:nil error:&error];
////    if (!isSuccess) {
////        DDLog(@"isFail");
////        DDLog(@"error__%@",error);
////        return NO;//写入失败
////        
////    }else{
////        DDLog(@"isSuccess");
////
////        return YES;//写入成功
////        
////    }
//    BOOL isSuccess = [data writeToFile:filePath atomically:YES];
//    if (isSuccess) {
//        DDLog(@"isSuccess");
//
//    }else{
//        DDLog(@"isFail");
//
//    }
//    
//    return nil;
//}
//


//如果需要另外编码,此处处理
+ (NSString *)encodeTheString:(NSString *)inputString{
    
    return inputString;
    
}
//AES加密
+ (NSString *)AESEncryptTheString:(NSString *)inputString{
    
//    inputString = [AESCrypt encrypt:inputString password:kACSEncrypt];
    return inputString;
}
//AES解密
+ (NSString *)AESDencryptTheString:(NSString *)inputString{
    
//    inputString = [AESCrypt decrypt:inputString password:kACSEncrypt];
    return inputString;
}


//+ (NSString *)encrypt:(NSString *)message password:(NSString *)password {
////    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
//    
////    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
//    NSString *base64EncodedString = [NSString hexStringFromData:encryptedData];
//    return base64EncodedString;
//}
//
//+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password {
////    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
//    NSData *encryptedData = [NSData dataFromHexString:base64EncodedString];
//    
////    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
//    
//    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
//}


- (id)AES128_EncryptParameters:(id)parameters collection:(id)collection{

    if ([parameters containsStringFromCollection:collection]) {
        parameters = [NSString AES128Encrypt:parameters key:kPwdKey_AES];
//        DDLog(@"parameters加密_\n%@",parameters);
       
    }
    return parameters ;
}

- (id)AES128_DecryptParameters:(id)parameters collection:(id)collection obj:(id)obj{
    if (![parameters isKindOfClass:[NSString class]]) return obj;
    
    if ([parameters containsStringFromCollection:collection]) {
//        if (![NSJSONSerialization isValidJSONObject:obj]) {
            obj = [NSString AES128Decrypt:obj key:kPwdKey_AES];
//            DDLog(@"responseObject解密_\n%@",obj);
        
//        }
    }
    return obj;
}

+ (void)animationViewContoller:(NSString *)animationType{
    
    NSDictionary * typeDict = @{
                                @"0":@"fade",
                                @"1":@"push",
                                @"2":@"reveal",
                                @"3":@"moveIn",
                                @"4":@"cube",
                                @"5":@"suckEffect",
                                @"6":@"rippleEffect",
                                @"7":@"oglFlip",
                                @"8":@"pageCurl",
                                @"9":@"pageUnCurl",
                                };
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = typeDict[animationType];
    //设置动画时长
    animation.duration = 0.5f;
    //设置运动的方向
    animation.subtype = kCATransitionFromTop;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"UIViewContollerAnimation"];
}

// 登陆后淡入淡出更换rootViewController
+ (void)restoreRootViewController:(UIViewController *)rootViewController{
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    typedef void (^Animation)(void);
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;

//    rootViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = navController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:keywindow
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];

}




@end
