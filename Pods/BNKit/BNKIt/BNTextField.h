//
//  BNTextField.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol keyInputTextFieldDelegate <NSObject>

- (void)textFieldDeleteBackward;

@end

@interface BNTextField : UITextField

@property (nonatomic, assign) CGFloat leftViewPadding;
@property (nonatomic, assign) CGFloat rightViewPadding;

@property (nonatomic,weak) id<keyInputTextFieldDelegate>keyInputDelegate;

@end
