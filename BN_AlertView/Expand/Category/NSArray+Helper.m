//
//  NSArray+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSArray+Helper.h"

@implementation NSArray (Helper)

+ (NSArray *)arrayWithItem:(id)item count:(NSInteger)count{
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < count; i++) {
        [marr addObject:item];
    }
    return marr.copy;
}

+ (NSArray *)arrayWithItemFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count{
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < count; i++) {
        
        NSInteger inter = (from + (arc4random() % (to - from + 1)));
        [marr addObject:@(inter)];
    }
    return marr.copy;
}


+ (NSArray *)arrayWithItemPrefix:(NSString *)prefix startIndex:(NSInteger)startIndex count:(NSInteger)count type:(NSNumber *)type{
    
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = startIndex; i <= startIndex + count; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%@%@",prefix,@(i)];
        
        switch ([type integerValue]) {
            case 1:
            {
                UIImage *image = [UIImage imageNamed:imgName];
                [marr addObject:image];
            }
                break;
            default:
                [marr addObject:imgName];
                
                break;
        }
        
    }
    return marr.copy;
}

- (NSArray *)BN_filterModelListByQuery:(NSString *)query isNumValue:(BOOL)isNumValue{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [obj valueForKey:query];
        value = isNumValue == NO ? value : [value numberValue];
        [marr addSafeObjct:value];
        
    }];
    return marr.copy;
}

- (NSArray *)BN_filterModelListByQuery:(NSString *)query{
    return [self BN_filterModelListByQuery:query isNumValue:NO];
    
}
    

- (NSMutableArray *)BN_filterByPropertyList:(NSArray *)propertyList isNumValue:(BOOL)isNumValue {
    __block NSMutableArray * listArr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray * marr = [NSMutableArray array];
        for (NSString * key in propertyList) {
            id value = [obj valueForKey:key];
            value = isNumValue == NO ? value : [value numberValue];
            [marr addSafeObjct:value];
        }
        [listArr addSafeObjct:marr];
        
    }];
    return listArr;
}

- (NSMutableArray *)BN_filterByPropertyList:(NSArray *)propertyList prefix:(NSString *)prefix isNumValue:(BOOL)isNumValue {
    NSMutableArray * marr = [NSMutableArray array];
    [propertyList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addSafeObjct:[prefix stringByAppendingString:obj]];
        
    }];
    NSMutableArray * list = [self BN_filterByPropertyList:marr isNumValue:isNumValue];
    return list;
}

- (NSArray *)BN_filterListByQueryContain:(NSString *)query{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([query containsString:obj]) {
            [marr addObject:obj];
            
        }
    }];
    return marr.copy;
}

@end
