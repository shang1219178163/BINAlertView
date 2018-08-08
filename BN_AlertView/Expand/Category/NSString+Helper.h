//
//  NSString+Helper.h
//  HuiZhuBang
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface NSString (Helper)

- (BOOL)isPureInteger;
//浮点形判断：
- (BOOL)isPureFloat;

/**
 字符串转number

 */
- (id)numberValue;


- (BOOL)isPureByCharSet:(NSString *)charSet;

- (NSDictionary *)dictionaryValue;

- (BOOL)isContainBlank;

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;

- (NSString *)stringBylimitLength:(NSInteger)limitLength;

- (NSString *)makeUnicodeToString;
    
- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set;

- (NSString *)md5Encode;

+ (NSString *)stringFromNumber:(NSNumber *)number;

+ (NSString *)stringFromInter:(NSInteger)inter;

+ (NSString *)stringFromFloat:(CGFloat )inter;

+ (NSString *)stringFromDouble:(double)inter;

/**
 随即字符串
 
 */
+ (NSString *)randomStringLength:(NSInteger)length;

/**
 随即产生字符串部分字符组合
 
 */
- (NSString *)randomStringPartLength:(NSInteger)length;

- (BOOL)isTimeStamp;

- (NSString *)toDateShort;

- (NSString *)toDateMonthDay;

//+ (NSString *)timeStampFromDate:(id)date;
//+ (NSString *)dateFromTimeStampStr:(NSString *)timeStampStr;
//+ (NSString *)dateFromTimeStamp:(NSTimeInterval)timeStamp;

+ (NSString *)stringFromData:(NSData *)data;


/**
 过滤特殊字符集
 */
- (id)filterString:(NSString *)filterString;
//- (NSString *)filterString:(NSString *)filterString;

- (NSString *)deleteWhiteSpaceBeginEnd;

- (NSString *)stringByTitle;

/**
 星号取代字符
 */
- (NSString *)stringByReplacingAsteriskRange:(NSRange)range;

/**
 根据range.length生成相应长度星号字符串
 */
- (NSString *)getAsteriskStringByRange:(NSRange)range;


/**
 取代字符串中某个索引字符
 */
- (NSString *)stringByReplacingCharacterIndex:(NSUInteger)index withString:(NSString *)string;

/**
 获取随机子字符串
 e.g.:0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ

 */
- (NSString *)randomStringLength:(NSInteger)length;

/**
 字符串包含集合任一元素

 @param collection 字符串集合
 @return 是否包含集合中的任一字符串
 */
- (BOOL)containsStringFromCollection:(id)collection;

/**
 
 @param array 字符串数组
 @return 包含所有元素
 */
- (BOOL)containArray:(NSArray *)array;

- (BOOL)stringContainArrObj:(NSArray *)array;

- (NSString *)getPlaceholder;

+ (NSString *)ramdomText;

+(NSString *)resultByAnObject:(NSString *)anObject multiplyAnothor:(NSString *)anothor;

@end
