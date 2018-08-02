//
//  BINPhotoItem.h
//  PhotoDisplay
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BINPhotoItem : NSObject

@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *highQuality_pic;

@property (nonatomic, strong) UIImage * originImage;

@end
