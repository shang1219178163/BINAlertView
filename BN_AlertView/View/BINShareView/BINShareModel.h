//
//  BINShareModel.h
//  ShareInfo
//
//  Created by hsf on 2017/9/1.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BINShareModel : NSObject
/*
 如果需要深度定制,所有参数加入此模型即可
 */
@property (nonatomic, copy) NSString * title;

//@property (nonatomic, copy) NSString * imageStr;
@property (nonatomic, copy) NSString * btnImageNomol;
@property (nonatomic, copy) NSString * btnImageHighlighted;

@end
