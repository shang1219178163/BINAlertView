//
//  BNAlertViewTwo.h
//  BINAlertView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kAlert_Title ;
FOUNDATION_EXPORT NSString * const kAlert_Msg ;
FOUNDATION_EXPORT NSString * const kAlert_Img ;
FOUNDATION_EXPORT NSString * const kAlert_Btns ;

@interface BNAlertViewTwo : UIView

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel * labelSub;

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) NSDictionary * params;

@property (nonatomic, copy) void (^block)(BNAlertViewTwo * view,NSInteger idx);

+(instancetype)viewWithParams:(NSDictionary *)params;

- (void)show;
- (void)dismiss;

@end
