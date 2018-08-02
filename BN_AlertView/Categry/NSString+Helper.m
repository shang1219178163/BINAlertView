
//
//  NSString+Helper.m
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSString+Helper.h"

#import <CommonCrypto/CommonHMAC.h>
#import <CoreLocation/CoreLocation.h>

@implementation NSString (Helper)

+ (NSString *)DDlogCoordinate:(CLLocationCoordinate2D)Coordinate{
    
    NSString * CoordinateStr = [NSString stringWithFormat:@"经纬度(%.6f ,%.6f)",Coordinate.latitude,Coordinate.longitude];
    return CoordinateStr;
}

+ (NSString *)DDlogLocationInfo:(CLPlacemark *)placemark{
    
    NSString * string = [NSString stringWithFormat:@"name-%@\nsubLocality----%@\nsubAdministrativeArea---%@",placemark.name,placemark.subLocality,placemark.administrativeArea];
    return string;
}

+ (NSArray *)getCoordinateStringInfo:(CLLocationCoordinate2D)coordinate{
    
    NSString * coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude];

    NSArray * arr = [coordinateStr componentsSeparatedByString:@","];
    return arr;
    
}

- (NSDictionary *)dictionaryValue{
    NSError *errorJson;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
    if (errorJson != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, errorJson);
#endif
    }
    return jsonDict;
}


/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//Unicode编码的字符串转成NSString
- (NSString *)makeUnicodeToString
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set
{
    NSRange rang = [self rangeOfCharacterFromSet:set];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}


+ (NSString *) md5:(NSString *)str {
    if (str == nil) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)stringFromInter:(NSInteger)inter
{
    NSString * sting = [@(inter) stringValue];
    return sting;
}

@end
