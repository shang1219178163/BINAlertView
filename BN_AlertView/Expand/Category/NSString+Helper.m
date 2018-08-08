
//
//  NSString+Helper.m
//  HuiZhuBang
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSString+Helper.h"

#import <CommonCrypto/CommonHMAC.h>
#import <CoreLocation/CoreLocation.h>

#import "NSDateFormatter+Helper.h"
#import "NSNumberFormatter+Helper.h"

@implementation NSString (Helper)

//整形判断
- (BOOL)isPureInteger{
    NSString * string = self;
    NSScanner * scan = [NSScanner scannerWithString:string];
    NSInteger val = 0;
    return [scan scanInteger:&val] && [scan isAtEnd];
}
//浮点形判断：
- (BOOL)isPureFloat{
    NSString * string = self;
    NSScanner * scan = [NSScanner scannerWithString:string];
    CGFloat val = 0.0;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

- (id)numberValue{
    if ([self isPureInteger] == YES) {
        return @([self integerValue]);
    }
    
    if ([self isPureFloat] == YES) {
        return @([self floatValue]);
    }
    return self;
    
}



- (BOOL)isPureByCharSet:(NSString *)charSet{
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charSet] invertedSet];
    NSString *result = [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    if ([result isEqualToString:self]) {
        return YES;
        
    }
    return NO;
    
}

- (NSDictionary *)dictionaryValue{
    NSError *errorJson;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&errorJson];
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
- (BOOL)isContainBlank{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//Unicode编码的字符串转成NSString
- (NSString *)makeUnicodeToString{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set{
    NSRange rang = [self rangeOfCharacterFromSet:set];
    if (rang.location == NSNotFound) {
        return NO;
    }
    else {
        return YES;
    }
}

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString{
    
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
    
}

- (NSString *)stringBylimitLength:(NSInteger)limitLength{
    
    NSString * string = self;
    if (string.length > limitLength) {
        string = [string substringToIndex:limitLength];
        string = [string stringByAppendingString:@"..."];
    }
    return string;
    
}

- (NSString *)md5Encode{
    
    // 码文数组(占 16 个字节)
    unsigned char resultArray[CC_MD5_DIGEST_LENGTH];
    // 编码
    CC_MD5(self.UTF8String, (CC_LONG)strlen(self.UTF8String), resultArray);
    // 码文
    NSMutableString *md5String = [NSMutableString string];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02X", resultArray[i]];// X 代表十六进制
        
    }
    return (NSString *)md5String;
}

+ (NSString *)stringFromNumber:(NSNumber *)number{
    NSString * sting = [number stringValue];
    return sting;
}


+ (NSString *)stringFromInter:(NSInteger)inter{
    NSString * sting = [@(inter) stringValue];
    return sting;
}


+ (NSString *)stringFromFloat:(CGFloat )inter{
    NSString * sting = [@(inter) stringValue];
    return sting;
}


+ (NSString *)stringFromDouble:(double)inter{
    NSString * sting = [@(inter) stringValue];
    return sting;
}

+ (NSString *)randomStringLength:(NSInteger)length{
    NSArray * alphabetArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
                                @"H",@"I",@"J",@"K",@"L",@"M",@"N",
                                @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
                                @"V",@"W",@"X",@"Y",@"Z"];
    
    NSString *randomString = @"";
    for (NSInteger i = 0; i < length; i++) {
        int x = arc4random() % 25;
        randomString = [NSString stringWithFormat:@"%@%@",randomString,alphabetArray[x]];
    }
    return randomString;
}

- (NSString *)randomStringPartLength:(NSInteger)length{
    NSAssert(self.length >= length, @"length应该小于字符串长度");
    
    unichar ch[self.length];
    for (NSInteger i = 0; i < self.length; i++) {
        ch[i] = [self characterAtIndex:i];
    }
    
    NSString *randomString = @"";
    for (NSInteger j = 0; j < length; j++) {
        int x = arc4random() % (self.length - 1);
        randomString = [NSString stringWithFormat:@"%@%C",randomString,ch[x]];
    }
    return randomString;
}

- (BOOL)isTimeStamp{
    NSString * string = self;
    if (string.length >= 8) {
        if ([string characterAtIndex:4] == '-' && [string characterAtIndex:7] == '-') return NO;

    }
    return YES;
    
}


- (NSString *)toDateShort{
    if ([self isTimeStamp] || self.length < 10) return self;

    NSString *dateStr = [self substringToIndex:10];
    return dateStr;
    
}

- (NSString *)toDateMonthDay{
    if ([self isTimeStamp] || self.length < 10) return self;
    
    NSString *dateStr = [self substringWithRange:NSMakeRange(5, 5)];
    return dateStr;
    
}

+ (NSString *)stringFromData:(NSData *)data{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

- (id)filterString:(NSString *)filterString{
    NSString * string = self;
    if (self.length > 0) {
//        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet];
        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:filterString] invertedSet];
        string = [string stringByAddingPercentEncodingWithAllowedCharacters:charset];
        
    }
    return string;
}

//- (NSString *)filterString:(NSString *)filterString{
//    NSString * string = self;
//    if (self.length > 0) {
//        //        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet];
//        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:filterString] invertedSet];
//        string = [string stringByAddingPercentEncodingWithAllowedCharacters:charset];
//        
//    }
//    return string;
//}

- (NSString *)deleteWhiteSpaceBeginEnd{
    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString * string = [self stringByTrimmingCharactersInSet:set];
    return string;
}

- (NSString *)stringByTitle{
    NSString * string = self;
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@""];

    return string;
    
}

- (NSString *)stringByReplacingAsteriskRange:(NSRange)range{
    NSString *replaceStr = self;
    if ([replaceStr substringWithRange:range]) {
        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:[self getAsteriskStringByRange:range]];

    }
    else{
        NSAssert([replaceStr substringWithRange:range], @"星号代替字符失败,请检查字符串和range");
        
    }
    return replaceStr;
}

- (NSString *)getAsteriskStringByRange:(NSRange)range{

    NSString * string = @"";
    for (NSInteger i = 0; i < range.length; i++) {
        string = [string stringByAppendingString:@"*"];
        
    }
    return string;
    
}

- (NSString *)stringByReplacingCharacterIndex:(NSUInteger)index withString:(NSString *)string{
    
    NSAssert(index < self.length, @"index非法!!!");
   return [self stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:string];
    
}

- (NSString *)randomStringLength:(NSInteger)length{
    NSString *fromString = self;

    NSMutableString *mStr = [NSMutableString stringWithCapacity:0];
    for (NSInteger i = 0; i < length; i++) {
        //        [mStr appendFormat: @"%C", [fromString characterAtIndex:arc4random_uniform((u_int32_t)fromString.length)]];
        NSUInteger randomIndex = arc4random()%length;
        [mStr appendFormat: @"%C", [fromString characterAtIndex:randomIndex]];
        
    }
    NSLog(@"randomString = %@", mStr);
    return mStr;
}

- (BOOL)containsStringFromCollection:(id)collection{
    
    if ([collection isKindOfClass:[NSArray class]] || [collection isKindOfClass:[NSSet class]]) {
        
        for (NSString * obj in collection) {
            
            if ([obj containsString:@","]) {
                NSArray * array = [obj componentsSeparatedByString:@","];
                if ([self containArray:array]) return YES;
                
            }
            else{
                if ([self containsString:obj]) return YES;

            }
        }
    }
    else if ([collection isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *dict = (NSDictionary *)collection;
        for (NSString * obj in dict.allKeys) {
            if ([self containsString:obj]) return YES;
            
        }
        
        for (NSString * obj in dict.allValues) {
            if ([self containsString:obj]) return YES;
            
        }
    }
    return NO;
    
}


/**

 @param array 字符串数组
 @return 包含所有元素
 */
- (BOOL)containArray:(NSArray *)array{
    
    for (NSString * obj in array) {
        if (![self containsString:obj]) return NO;
        
    }
    return YES;

}

//- (BOOL)containsStringFromCollection:(id)collection{
//    
//    if ([collection isKindOfClass:[NSArray class]] || [collection isKindOfClass:[NSSet class]]) {
//        
//        for (NSString * obj in collection) {
//            if ([self containsString:obj]) return YES;
//            
//        }
//    }
//    else if ([collection isKindOfClass:[NSDictionary class]]){
//        
//        NSDictionary *dict = (NSDictionary *)collection;
//        for (NSString * obj in dict.allKeys) {
//            if ([self containsString:obj]) return YES;
//            
//        }
//        
//        for (NSString * obj in dict.allValues) {
//            if ([self containsString:obj]) return YES;
//            
//        }
//    }
//    return NO;
//
//}

- (BOOL)stringContainArrObj:(NSArray *)array{
    
    for (NSString * string in array) {
        [self containsString:string];
        return YES;
    }
    return NO;
}

- (NSString *)getPlaceholder{
    
    NSString * placeHolder = [NSString stringWithFormat:@"请输入%@",self];
    placeHolder = [placeHolder stringByReplacingOccurrencesOfString:@" " withString:@""];
    placeHolder = [placeHolder stringByReplacingOccurrencesOfString:@":" withString:@""];
    return placeHolder;
}


+ (NSString *)ramdomText{
    
    NSArray * array = @[@"测试数据,",@"test_",@"AAAAA-",@"BBBBB>",@"秦时明月",@"犯我大汉天威者,虽远必诛",];
    
    CGFloat length = arc4random()%15 + 5;
    NSMutableString * mstr = [NSMutableString stringWithCapacity:0];
    for (NSUInteger i = 0; i < length; i++) {
        
        NSInteger random = (NSInteger)(arc4random() % array.count);
        NSString * text = array[random];
        [mstr appendString:text];
    }
    return mstr;
    
}


+(NSString *)resultByAnObject:(NSString *)anObject multiplyAnothor:(NSString *)anothor{
    
    CGFloat weight = [anObject floatValue] * [anothor floatValue];
    return [NSString stringFromFloat:weight];
    
}

@end
