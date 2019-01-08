//
//  CustomAlertView.m
//  CustomeAlertView
//
//  Created by Shang on 14-10-16.
//  Copyright (c) 2014年 SouFun. All rights reserved.
//

#import "CustomAlertView.h"

#define kW_LABEL 280
#define kX_GAP 10
#define kFONTSIZE 15

#define kH_BTN 50


@implementation CustomAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, kScreen_width - kX_GAP*2, 0);
        self.center = self.superview.center;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];

    }
    return self;
}

-(id)initWithTitle:(NSString *)title message:(NSString *)msg orCustomeView:(UIView *)customeView delegate:(id)delegate buttonTitles:(NSArray *)buttonTitles{
    
//    UIView * alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width - kX_GAP*2, 0)];
//    alertView.center = self.superview.center;
    
    CGSize  titleSize = CGSizeZero;
    if (title != nil) {
        
        titleSize = [self sizeWithText:title font:@(kFONTSIZE) width:kW_LABEL];
    }
    
    
    CGSize  msgSize = CGSizeZero;
    CGSize  customeViewSize = CGSizeZero;
    if (customeView != nil) {
        
        customeViewSize = customeView.frame.size;
    }else{
        
        msgSize = [self sizeWithText:msg font:@(kFONTSIZE) width:kW_LABEL];
    }
    
    CGSize  btnSize = CGSizeZero;
    if (buttonTitles.count != 0 ) {
        
        btnSize.height = kH_BTN;
        
        CGFloat buttonWidth = (kScreen_width - 2 * kX_GAP) / buttonTitles.count;
        
        for (int i = 0; i < [buttonTitles count]; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setFrame:CGRectMake(i * buttonWidth, self.frame.size.height - kH_BTN, buttonWidth, kH_BTN)];
            
            [btn addTarget:self action:@selector(customAlertViewButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:i];
            
            [btn setTitle:[buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:kFONTSIZE]];
            
            [self addSubview:btn];
        }
 
    }
    
    
    if (customeView != nil) {
        
        self.frame = CGRectMake(0, 0, kScreen_width - kX_GAP * 2, titleSize.height + customeViewSize.height + btnSize.height);
    }else{
        
        self.frame = CGRectMake(0, 0, kScreen_width - kX_GAP * 2, titleSize.height + msgSize.height + btnSize.height);
    }

    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

-(void)customAlertViewButtonTouchUpInside:(UIButton *)sender{
    
    
    NSLog(@"__%ld",sender.tag);
}

-(void)showCustomAlertView{
    
    
    
//    UIView * grayView = [[UIView alloc]initWithFrame:self.superview.frame];
//    [self.superview addSubview:grayView];
    [self.parView addSubview:self];
    [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [[[UIApplication.sharedApplication windows] firstObject] addSubview:self];

    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
//						 self.superview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         self.superview.backgroundColor = [UIColor yellowColor];
//                         grayView.backgroundColor = [UIColor redColor];
                         
                         self.layer.opacity = 1.0f;
                         self.layer.transform = CATransform3DMakeScale(1, 1, 1);
                         
                         self.layer.borderWidth = 5;
                         self.layer.borderColor = [UIColor clearColor].CGColor;
                         
					 }
					 completion:NULL
     ];

}

- (void)deviceOrientationDidChange: (NSNotification *)notification{
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication.sharedApplication statusBarOrientation];
    
    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    CGAffineTransform rotation;
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
            break;
            
        default:
            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
            break;
    }
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
					 animations:^{
                         self.transform = rotation;
					 }
					 completion:^(BOOL finished){
                         // fix errors caused by being rotated one too many times
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                             UIInterfaceOrientation endInterfaceOrientation = [UIApplication.sharedApplication statusBarOrientation];
                             if (interfaceOrientation != endInterfaceOrientation) {
                                 // TODO user moved phone again before than animation ended: rotation animation can introduce errors here
                             }
                         });
                     }
	 ];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
