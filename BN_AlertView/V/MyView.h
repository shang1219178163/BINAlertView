//
//  MyView.h
//  CustomeAlertView
//
//  Created by Shang on 14-10-16.
//  Copyright (c) 2014年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyViewDelegate <NSObject>

- (void)customViewButtonTouchUpInside:(UIView *)myView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface MyView : UIView

@property (assign, nonatomic) id<MyViewDelegate>delegate;

@property (nonatomic, retain) UIView * activityOnView;

- (id)initWithFrame:(CGRect)frame Title:(NSString *)title message:(NSString *)msg orCustomeView:(UIView *)customeView delegate:(id /*<CustomAlertViewDelegate>*/)delegate buttonTitles:(NSArray *)buttonTitles;

-(void)showMyView;
-(void)dismissMyView;

@end
