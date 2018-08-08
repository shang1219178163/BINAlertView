//
//  NSString+Convert.h
//  HuiZhuBang
//
//  Created by BIN on 2018/1/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Convert)

// 十六进制转换为普通字符串的
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的
//+ (NSString *)hexStringFromString:(NSString *)string;
- (NSString *)hexString;

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

+ (NSString *)hexStringFromData:(NSData *)data;


@end
