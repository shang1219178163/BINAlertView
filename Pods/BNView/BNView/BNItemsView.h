//
//  BNItemsView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNItemsView : UIView

@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, copy) void(^block)(BNItemsView *itemsView, UIButton *btn);


@end

NS_ASSUME_NONNULL_END
