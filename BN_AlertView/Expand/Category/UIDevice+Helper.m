
//
//  UIDevice+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIDevice+Helper.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "NSString+Helper.h"
#import "UIDevice+FCUUID.h"

@interface UIDevice (Private)

- (NSString *) macaddress;

@end

@implementation UIDevice (Helper)


- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods

+(NSString *)app_Name{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return  infoDict[@"CFBundleDisplayName"];
}

+(UIImage *)app_Icon{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoDict valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage * image = [UIImage imageNamed:icon];
    return image;
    
}

+(NSString *)app_Version{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return  infoDict[@"CFBundleShortVersionString"];
}
+(NSString *)app_build{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return  infoDict[@"CFBundleVersion"];
}
+(NSString *)phone_SystemVersion{
    return  [[UIDevice currentDevice] systemVersion];
    
}
+(NSString *)phone_SystemName{
    return  [[UIDevice currentDevice] systemName];
    
}

+(NSString *)phone_Name{
    return  [[UIDevice currentDevice] name];
    
}


+(NSString *)phone_Model{
    return  [[UIDevice currentDevice] model];
    
}

+(NSString *)phone_localizedModel{
    return  [[UIDevice currentDevice] localizedModel];
    
}

- (NSString *)uniqueDeviceIdentifier{
//    NSString *macaddress = [[UIDevice currentDevice] macaddress];
//    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
//
//    NSString *stringToHash = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
//    NSString *uniqueIdentifier = [NSString md5:stringToHash];
    
//    return stringToHash;
    
    NSString * uuidString = [[UIDevice currentDevice] uuid];
    return uuidString;
    
}

- (NSString *)uniqueGlobalDeviceIdentifier{
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
    NSString *uniqueIdentifier = [macaddress md5Encode];
    
    return uniqueIdentifier;
}

- (NSString *) platform
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return platform;
}

- (NSString *) platformString
{
    NSString *deviceString = [self platform];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";

    if ([deviceString isEqualToString:@"i386"] || [deviceString isEqualToString:@"x86_64"]) return @"Simulator";
    return @"";
}

@end
