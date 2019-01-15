//
//  BNSegmentView.h
//  BN_AlertView
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNSegmentView : UIView

@property (nonatomic, strong) UISegmentedControl * segmentCtl;
@property (nonatomic, strong) UIView * indicator;

@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
