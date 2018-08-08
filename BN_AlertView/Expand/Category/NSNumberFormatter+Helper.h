//
//  NSNumberFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (Helper)

+ (NSNumberFormatter *)numWithIdentify:(NSString *)identify;

+ (NSNumberFormatter *)numFormat:(NSString *)formatStr;

+ (NSString *)numStyle:(NSNumberFormatterStyle)nstyle number:(id)number;

@end
