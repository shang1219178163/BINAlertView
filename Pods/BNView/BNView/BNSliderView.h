//
//  BNSliderView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNSliderView : UIView

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelRight;
@property (nonatomic, strong) UISlider * sliderCtl;
@property (nonatomic, assign) NSTextAlignment ctlAlignment;

@property (nonatomic, strong) void(^block)(BNSliderView *view);

@end

NS_ASSUME_NONNULL_END
