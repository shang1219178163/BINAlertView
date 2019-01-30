//
//  BNSuspendButton.h
//  suspendBtnDemo
//
//  Created by BIN on 2017/12/12.
//  Copyright © 2017年 郭永红. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNSuspendButton : UIButton

+(instancetype)spBtnRect:(CGRect)rect image:(id)image parController:(UIViewController *)parController;

@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, assign) CGFloat padding;

@end
