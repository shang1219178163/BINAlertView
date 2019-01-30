//
//  BNSwitchView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNSwitchView : UIView

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UISwitch * switchCtl;
@property (nonatomic, assign) NSTextAlignment ctlAlignment;

@property (nonatomic, strong) void(^block)(BNSwitchView *view);


@end

NS_ASSUME_NONNULL_END
