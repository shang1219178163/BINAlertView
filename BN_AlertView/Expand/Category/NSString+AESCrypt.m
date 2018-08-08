//
//  NSString+AESCrypt.m
//  HuiZhuBang
//
//  Created by BIN on 2018/1/11.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSString+AESCrypt.h"

#import <CommonCrypto/CommonCrypto.h>
#import "GTMBase64.h"

#import "NSData+AESCrypt.h"

#import "NSString+Convert.h"
#import "NSData+Convert.h"

@implementation NSString (AESCrypt)

+ (NSString *)AES128Encrypt:(NSString *)content key:(NSString *)key
{
    
    if( ![self validKey:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
        NSLog(@"diff is %d",diff);
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] =0x0000;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [key UTF8String],
                                          kCCKeySizeAES128,
                                          [key UTF8String],
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
//        return [GTMBase64 stringByEncodingData:resultData];
        return [NSString hexStringFromData:resultData];
    }
    free(buffer);
    return nil;
}



+ (NSString *)AES128Decrypt:(NSString *)content key:(NSString *)key
{
    
    if( ![self validKey:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
//    NSData *data = [GTMBase64 decodeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [NSData dataFromHexString:content];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [key UTF8String],
                                          kCCBlockSizeAES128,
                                          [key UTF8String],
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        NSString *decoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return [self processDecodedString:decoded];
    }
    
    free(buffer);
    return nil;
    
}

+ (NSString *)processDecodedString:(NSString *)decoded
{
    if( decoded==nil || decoded.length==0 ){
        return nil;
    }
    const char *tmpStr=[decoded UTF8String];
    int i=0;
    
    while( tmpStr[i]!='\0' )
    {
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
    
}

- (NSString *)processDecodedString:(NSString *)decoded
{
    if( decoded==nil || decoded.length==0 ){
        return nil;
    }
    const char *tmpStr=[decoded UTF8String];
    int i=0;
    
    while( tmpStr[i]!='\0' )
    {
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
    
}

+ (BOOL)validKey:(NSString*)key
{
    if( key==nil || key.length !=16 ){
        return NO;
    }
    return YES;
}



/**
 字符串aes加密
 
 @param key 加密秘钥(tips:  NOPadding)
 @param encodeType @"0" hex; default base64
 @return 加密字符串
 
 */
- (NSString *)AES128EncryptKey:(NSString *)key encodeType:(NSString *)encodeType
{
    NSAssert( self != nil && key != nil, @"内容和key不能为nil");
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    //
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
        NSLog(@"diff is %d",diff);
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] =0x0000;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [key UTF8String],
                                          kCCKeySizeAES128,
                                          [key UTF8String],
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString * resultString = nil;
        
        switch ([encodeType integerValue]) {
            case 0:
                resultString = [NSString hexStringFromData:resultData];
                
                break;
            default:
                resultString = [GTMBase64 stringByEncodingData:resultData];
                
                break;
        }
        return resultString;
    }
    free(buffer);
    return nil;
}

/**
 字符串aes解密
 
 @param key 加密秘钥(tips:  NOPadding)
 @param encodeType @"0" hex; default base64
 @return 普通字符串
 */
- (NSString *)AES128DecryptKey:(NSString *)key encodeType:(NSString *)encodeType
{
    
    NSAssert( self != nil && key != nil, @"内容和key不能为nil");
    
    NSData * data = nil;
    switch ([encodeType integerValue]) {
        case 0:
            data = [NSData dataFromHexString:self];

            break;
        default:
            data = [GTMBase64 decodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];

            break;
    }
    
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [key UTF8String],
                                          kCCBlockSizeAES128,
                                          [key UTF8String],
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        NSString *decoded = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return [self processDecodedString:decoded];
    }
    
    free(buffer);
    return nil;
}

/**
 字符串-->二进制-->二进制(加密)-->64字符串(加密)
 
 @param key 秘钥
 @return 加密字符串
 */
- (NSString *)AES256EncryptWithKey:(NSString *)key
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES256EncryptWithKey:key];
    
    NSString *encryptedString = [encryptedData base64Encoding];
    return encryptedString;
}


/**
 64字符串(加密)-->二进制(加密)-->二进制(解密)-->字符串
 
 @param key 秘钥
 @return 加密字符串
 */
- (NSString *)AES256DecryptWithKey:(NSString *)key
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData AES256DecryptWithKey:key];
    
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    return plainString;
}

@end
