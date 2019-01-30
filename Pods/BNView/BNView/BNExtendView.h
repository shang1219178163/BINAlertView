//
//  BNExtendView.h
//  BNCollectionView
//
//  Created by hsf on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

/**
 使用此视图,所有图片大小要一致
 padding需要在items之前设置
 */

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kExtendItem_img ;
FOUNDATION_EXPORT NSString * const kExtendItem_VC ;
FOUNDATION_EXPORT NSString * const kExtendKey_btn ;
FOUNDATION_EXPORT NSString * const kExtendKey_rect ;
FOUNDATION_EXPORT NSString * const kExtendKey_rectOrigin ;

@interface BNExtendView : UIView

@property (nonatomic, strong) NSString * frontImage;
@property (nonatomic, strong) NSString * backImage;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSArray * imgList;
@property (nonatomic, strong) NSArray * itemDictList;
@property (nonatomic, assign) NSNumber *direction;//@0,@1,@2,@3上左下右

@property (nonatomic, assign) BOOL isLock;

@property (nonatomic, copy) void(^block)(BNExtendView * view, id obj, UIButton *sender);

@end
