
//
//  NSObject+Testing.m
//  BINAlertView
//
//  Created by hsf on 2018/3/24.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "NSObject+Testing.h"

@implementation NSObject (Testing)

-(BOOL)hasContainAttDict:(NSDictionary *)attDict list:(NSArray *)list type:(NSNumber *)type{
    
    
    NSDictionary * dict = @{
                            @1 : @"IN",
                            @2 : @"CONTAINS",
                            @3 : @"like",
                            @4 : @"BEGINSWITH",
                            @5 : @"IN",
                            @6 : @"IN",
                            @7 : @"IN",

                            };

    NSString * SQL = @"";
    for (NSInteger i = 0; i < attDict.allKeys.count; i++) {
        NSString * key = attDict.allKeys[i];
        NSString * obj = attDict[key];
        
        SQL = [NSString stringWithFormat:@"%@ LIKE[c] %@",key,obj];
        if (i < attDict.allKeys.count - 1) {
            SQL = [SQL stringByAppendingString:@"&&"];
            
        }
    }
    
    //    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"%@", SQL];;
    //    preicate = [NSPredicate predicateWithFormat:@"%@ LIKE[c] %@",@"piggery", title];
//    DDLog(@"preicate__%@",preicate);
//
//    NSArray * filterList = [list filteredArrayUsingPredicate:preicate];
//    if (filterList.count > 0) return YES;
    
    return NO;
    
}

@end
