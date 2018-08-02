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
    for (NSInteger i = startIndex; i < startIndex + count; i++) {
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

@end
