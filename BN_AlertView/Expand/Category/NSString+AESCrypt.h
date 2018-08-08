//
//  NSString+AESCrypt.h
//  HuiZhuBang
//
//  Created by BIN on 2018/1/11.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPwdKey_AES           @"mbqh1Gtpj9L8pJuv"

@interface NSString (AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;

+ (NSString *)AES128Encrypt:(NSString *)content key:(NSString *)key;
+ (NSString *)AES128Decrypt:(NSString *)content key:(NSString *)key;

/**
 字符串aes加密
 
 @param key 加密秘钥(tips:  NOPadding)
 @param encodeType @"0" hex; default base64
 @return 加密字符串
 
 */
- (NSString *)AES128EncryptKey:(NSString *)key encodeType:(NSString *)encodeType;

/**
 字符串aes解密
 
 @param key 加密秘钥(tips:  NOPadding)
 @param encodeType @"0" hex; default base64
 @return 普通字符串
 */
- (NSString *)AES128DecryptKey:(NSString *)key encodeType:(NSString *)encodeType;


@end
