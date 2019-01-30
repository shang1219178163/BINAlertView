//
//  BNSuspendView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/25.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNSuspendBtn : UIButton

@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic, weak) UIViewController *parController;

@end

