//
//  NSMutableArray+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/9/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Helper)

-(void)addSafeObjct:(id)obj;

- (void)replaceObject:(id)object withObject:(id)anObject;

@end
