//
//  BN_RadioView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

/**
 遵循协议的圆形单选按钮
 */



#import <UIKit/UIKit.h>

@interface BN_RadioViewZero : UIImageView

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL onTheMap;

@property (nonatomic, copy) void(^block)(BN_RadioViewZero *radioView);

- (instancetype)initWithFrame:(CGRect)frame imgName_N:(NSString *)imgName_N imgName_H:(NSString *)imgName_H;


@end
