//
//  BINShareDataModel.h
//  ShareInfo
//
//  Created by hsf on 2017/9/1.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BINShareDataModel : NSObject

@property (nonatomic, copy) NSString * shareTitle;
@property (nonatomic, copy) NSString * shareDate;
@property (nonatomic, copy) NSString * shareDesc;
@property (nonatomic, copy) NSString * shareContent;
@property (nonatomic, copy) NSString * shareFrom;
@property (nonatomic, copy) NSArray * shareImages;

@property (nonatomic, copy) NSString * shareUrl;

@end
