//
//  NSArray+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Helper)

+ (NSArray *)arrayWithItem:(id)item count:(NSInteger)count;

+ (NSArray *)arrayWithItemFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count;


/**
   有序图片数组或者字符串数字

 @param type @0字符串数组 ,@1:UIImage数组,
 @return 数组
 */
+ (NSArray *)arrayWithItemPrefix:(NSString *)prefix startIndex:(NSInteger)startIndex count:(NSInteger)count type:(NSNumber *)type;

@end
