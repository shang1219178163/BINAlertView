//
//  NSString+Helper.h
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface NSString (Helper)

+ (NSString *)DDlogCoordinate:(CLLocationCoordinate2D)Coordinate;
+ (NSString *)DDlogLocationInfo:(CLPlacemark *)placemark;
//返回经纬度字符串数组
+ (NSArray *)getCoordinateStringInfo:(CLLocationCoordinate2D)coordinate;

- (NSDictionary *)dictionaryValue;

- (BOOL)isContainBlank;
- (NSString *)makeUnicodeToString;
- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set;

+ (NSString *) md5:(NSString *)str;

+ (NSString *)stringFromInter:(NSInteger)inter;

@end
