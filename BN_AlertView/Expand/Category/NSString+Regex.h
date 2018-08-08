//
//  NSString+Regex.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/23.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

- (BOOL)isValidMobileNumber;

- (BOOL)isValidEmailAddress;

- (BOOL)isValidSimpleVerifyIdentityCardNum;

- (BOOL)isValidCarNumber;

- (BOOL)isValidMacAddress;

- (BOOL)isValidUrl;

- (BOOL)isValidChinese;;

- (BOOL)isValidPostalcode;

- (BOOL)isValidTaxNo;

///精确的身份证号码有效性检测
+ (BOOL)isValidAccurateVerifyIDCardNumber:(NSString *)value;

- (BOOL)isValidBankCardluhmCheck;

- (BOOL)isValidIPAddress;


@end
