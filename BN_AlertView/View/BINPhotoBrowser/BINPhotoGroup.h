//
//  BINPhotoGroup.h
//  PhotoDisplay
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BINPhotoItem.h"
#import "BINPhotoBrowser.h"
#import "BINPhotoBrowserView.h"

#import "BINPhotoBrowserConfig.h"
#import "Utilities_DM.h"

@interface BINPhotoGroup : UIView

@property (nonatomic, strong) NSArray *photoItemArray;
@property (nonatomic, assign) CGSize photoItemSize;

@end
