//
//  NSDictionary+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

//字典转json格式字符串：
- (NSString *)JSONValue{
    
    NSString * jsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&parseError];
        if (parseError != nil) {
#ifdef DEBUG
            NSLog(@"fail to get NSData from Dict: %@, error: %@", self, parseError);
#endif
        }
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    } else {
        NSLog(@"JSON数据生成失败，请检查数据格式!");
        
    }
    return jsonString;
}

@end
