//
//  UIDevice+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Helper)

- (NSString *)uniqueDeviceIdentifier;

- (NSString *)uniqueGlobalDeviceIdentifier;

- (NSString *)platformString;

    
@end
