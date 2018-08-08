

//
//  NSData+Helper.m
//  Location
//
//  Created by BIN on 2017/12/23.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSData+Helper.h"

#import "NSObject+Helper.h"

@implementation NSData (Helper)

+(NSData *)dataFromObj:(id)obj{
 
    NSData * data = nil;
    if ([obj isKindOfClass:[NSString class]]) {
        data = [obj dataUsingEncoding:NSUTF8StringEncoding];
        
    }
    else if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]){
        
        NSError * error = nil;
        data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];

        if (data && error == nil) {
            return data;
        }
    }
    else if ([obj isKindOfClass:[UIImage class]]){
        data = UIImageJPEGRepresentation(obj, 1.0);
        
    }
    else{
        NSArray * array = @[@"NSString", @"NSDictionary", @"NSArray", @"UIImage"];
        NSAssert(([[self class] isKindClassArray:array value:obj]), @"");
    
    }
    return data;
    
}


@end
