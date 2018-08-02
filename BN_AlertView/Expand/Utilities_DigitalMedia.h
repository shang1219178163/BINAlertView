//
//  Utilities_DigitalMedia.h
//  WeiHouBao
//
//  Created by hsf on 2017/9/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities_DigitalMedia : NSObject

+ (BOOL)hasAccessRightOfPhotosLibrary;

+ (BOOL)hasAccessRightOfCameraUsage;

+ (BOOL)imageOne:(UIImage *)image equelToImageTwo:(NSString *)imageStr;

//待试用
- (UIImage *)getThumbnailFromImage:(UIImage *)image size:(CGSize)size;

//1.自动缩放到指定大小
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

//2.保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

#pragma mark - - 二分压缩法
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;
//递归缩小压缩系数
+ (UIImage *)compressImage:(UIImage *)image maxFileSize:(NSInteger)maxFileSize;

@end
