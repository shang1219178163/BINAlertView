//
//  CustomAlertView.h
//  CustomeAlertView
//
//  Created by Shang on 14-10-16.
//  Copyright (c) 2014年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomAlertViewDelegate

- (void)customAlertViewButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface CustomAlertView : UIView

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) UIView * customeView;
@property (nonatomic, retain) UIView * parView;

@property (nonatomic, retain) NSArray * buttonTitles;

@property (copy) void (^onButtonTouchUpInside)(CustomAlertView *alertView, int buttonIndex);

- (id)initWithTitle:(NSString *)title message:(NSString *)msg orCustomeView:(UIView *)customeView delegate:(id /*<CustomAlertViewDelegate>*/)delegate buttonTitles:(NSArray *)buttonTitles;


- (void)showCustomAlertView;

- (void)customAlertViewButtonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(CustomAlertView *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;

@end
