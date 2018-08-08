//
//  NSData+Convert.h
//  HuiZhuBang
//
//  Created by BIN on 2018/1/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Convert)

+ (NSData *)base64DataFromString:(NSString *)string;

+ (NSData *)dataFromHexString:(NSString *)hexString;

@end
