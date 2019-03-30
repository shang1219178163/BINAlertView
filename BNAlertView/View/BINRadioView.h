//
//  BINRadioView.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BINRadioView;

typedef void(^BlockRadioView) (BINRadioView *radioView);

@interface BINRadioView : UIView

//@property (nonatomic, assign) NSInteger selectIndex;
//@property (nonatomic, strong) UIColor * indicatorColor;
//@property (nonatomic, strong) UIColor * titleColorSelected;
//@property (nonatomic, strong) UIColor * gapLineColor;

@property (nonatomic, assign) BOOL isSelected;
/**
 地图上方视图添加手势,有时会与地图手势冲突,所以单独做了处理,地图上使用此控件只需 onTheMap置位YES即可
 */
@property (nonatomic, assign) BOOL onTheMap;

@property (nonatomic, copy) BlockRadioView blockRadioView;

- (id)initWithFrame:(CGRect)frame imageNomorl:(NSString *)imageNomorl imageSelected:(NSString *)imageSelected isSelected:(BOOL)isSelected;

- (void)actionWithBlock:(BlockRadioView)radioView;

@end
