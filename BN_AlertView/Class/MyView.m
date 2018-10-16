//
//  MyView.m
//  CustomeAlertView
//
//  Created by Shang on 14-10-16.
//  Copyright (c) 2014年 SouFun. All rights reserved.
//

#import "MyView.h"

#define iOS(version) (([[[UIDevice currentDevice] systemVersion] intValue] >= version)?1:0)


#define kScreen_width  [[UIScreen mainScreen]bounds].size.width
#define kScreen_height [[UIScreen mainScreen]bounds].size.height

#define kX_GAP_OF_WINDOW 15//距离window边界

#define kX_GAP 10//self上子视图边界

#define kFONTSIZE 15

#define kH_LABLE 25//lable高度
#define kH_BTN 50//btn高度

//RGB色值
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@implementation MyView

- (void)addLabelWithRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag font:(CGFloat)font textColor:(UIColor *)textColor backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment
{
    if (![self viewWithTag:tag]) {
		UILabel * label = [[UILabel alloc] initWithFrame:rect];
        [label setBackgroundColor:backgroudColor];
//        [label setBackgroundColor:[UIColor clearColor]];
        
        [label setText:text];
        [label setFont:[UIFont systemFontOfSize:font]];
        [label setTextColor:textColor];
        [label setTextAlignment:alignment];
        [label setNumberOfLines:1];
        [label setLineBreakMode:NSLineBreakByTruncatingTail];
        [label setTag:tag];
        [self addSubview:label];
	}else{
        UILabel * label = (UILabel *)[self viewWithTag:tag];
        [label setFrame:rect];
        [label setText:text];
    }
}

-(void)addBtnWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag{
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = frame;
    btn.tag = tag;

    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor cyanColor].CGColor;
    
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];

    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_RGBA(30, 117, 217, 1) forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(btnCommand:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
}

-(void)btnCommand:(UIButton *)sender{
    
    [self removeActivityBackgroundView];
    
    NSLog(@"%@",sender.titleLabel.text);
    
    if ([self.delegate respondsToSelector:@selector(customViewButtonTouchUpInside:clickedButtonAtIndex:)]) {
        [self.delegate customViewButtonTouchUpInside:self clickedButtonAtIndex:sender.tag];
    }
    
    [self removeFromSuperview];

}
-(void)dismissMyView{
    
    if (0) {//第一个是取消
        
        UIButton * btn = (UIButton *)[self viewWithTag:107];
        [self btnCommand:btn];
    }else{
        
        [self removeActivityBackgroundView];
        [self removeFromSuperview];
    }
    
}

- (CGSize)sizeWithText:(NSString *)text font:(CGFloat)font width:(CGFloat)maxWidth{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;//折行方式
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName,paragraphStyle.copy,NSParagraphStyleAttributeName,nil];
    CGSize size =[text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;

    size.height = ceil(size.height);
    size.width = ceil(size.width);

    //如果文字中可能会出现emoji表情的话, emoji的高度比文字要高一点点,+2
    //    size.height = size.height+2;
    return size;
}

-(void)showMyView{
    
    [self addActivityBackgroundView];
    
    //    self.transform = CGAffineTransformMakeScale(2, 2);
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);

    //UIViewAnimationOptionCurveEaseIn从外往里,UIViewAnimationOptionCurveEaseOut从里往外
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                         self.backgroundColor = UIColor.whiteColor;
                         
                         [[[[UIApplication sharedApplication]windows]firstObject]addSubview:self];
                         
                     }
                     completion:NULL
     ];

}

- (id)initWithFrame:(CGRect)frame Title:(NSString *)title message:(NSString *)msg orCustomeView:(UIView *)customeView delegate:(id /*<MyViewDelegate>*/)delegate buttonTitles:(NSArray *)buttonTitles{
    
    
    self = [super initWithFrame:frame];
    if (self) {

        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6 ;
        self.layer.borderColor = UIColor.whiteColor.CGColor;
        self.layer.borderWidth = 1.0 ;
        
        
        if (CGRectEqualToRect(self.frame, CGRectZero)) {
            
            self.frame = CGRectMake(0, 0, kScreen_width - kX_GAP_OF_WINDOW * 2, 180);
        }
        /*
        if (title != nil) {
            
            [self addLabelWithRect:CGRectMake(kX_GAP, kX_GAP, self.frame.size.width - kX_GAP * 2, 25) text:@"11111" tag:101 font:15 textColor:nil backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentCenter];
        }
        
        if (msg != nil) {
            
            [self addLabelWithRect:CGRectMake(kX_GAP, kX_GAP + 25+5, self.frame.size.width - kX_GAP * 2, 25) text:@"2222" tag:102 font:15 textColor:nil backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentCenter];
        }
        
        if (customeView != nil) {
            
        
        }
        
        NSInteger count = buttonTitles.count;
        for (int i = 0; i < count; i++) {
            
            [self addBtnWithFrame:CGRectMake( self.frame.size.width/count * i, self.frame.size.height - 50, self.frame.size.width/count, 50) title:[NSString stringWithFormat:@"btn_%d",i] tag:(100+i)];
        }

        */
        CGSize  titleSize = CGSizeZero;
        CGFloat maxWidth = kScreen_width - (kX_GAP_OF_WINDOW + kX_GAP)*2;
        if (title != nil) {
            
            titleSize = [self sizeWithText:title font:@(kFONTSIZE) width:maxWidth];
            [self addLabelWithRect:CGRectMake(kX_GAP, kX_GAP, self.frame.size.width - kX_GAP * 2, kH_LABLE) text:title tag:101 font:kFONTSIZE textColor:nil backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentCenter];
        }
        
        
        CGSize  msgSize = CGSizeZero;
        CGSize  customeViewSize = CGSizeZero;
        if (customeView != nil) {
            
            if (CGRectGetWidth(customeView.frame) > CGRectGetWidth(self.frame)) {
                
                customeView.clipsToBounds = YES;
            }
            
            customeViewSize = customeView.frame.size;
            customeView.frame = CGRectMake(0, kX_GAP + titleSize.height + 5,CGRectGetWidth(self.frame), CGRectGetHeight(customeView.frame));

//            customeViewSize = customeView.frame.size;
//            if (customeView.frame.size.width < self.frame.size.width - kX_GAP * 2) {
//                
//                customeView.frame = CGRectMake((self.frame.size.width - customeView.frame.size.width)/2, kX_GAP + titleSize.height + 5, customeView.frame.size.width, customeView.frame.size.height);
//
//            }else{
//                customeView.frame = CGRectMake(kX_GAP, kX_GAP + titleSize.height + 5, self.frame.size.width - kX_GAP * 2, customeView.frame.size.height);
//            }
            [self addSubview:customeView];
        }else{
            
            msgSize = [self sizeWithText:msg font:@(kFONTSIZE) width:maxWidth];
            [self addLabelWithRect:CGRectMake(kX_GAP, kX_GAP + kH_LABLE + 5, self.frame.size.width - kX_GAP * 2, kH_LABLE) text:msg tag:102 font:kFONTSIZE textColor:nil backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentCenter];

        }
        
        CGSize  btnSize = CGSizeZero;
        NSInteger btnCount = buttonTitles.count;
        if (btnCount != 0 ) {
            
            btnSize.height = kH_BTN;
            
            
            if (customeView != nil) {
                
                self.frame = CGRectMake(0, 0, self.frame.size.width,kX_GAP + titleSize.height + 5 + customeViewSize.height + btnSize.height);
                
                CGFloat maxHeight = kScreen_height - 64 * 2;
                if (CGRectGetHeight(self.frame) > maxHeight) {
                    
                    self.frame = CGRectMake(0, 0, self.frame.size.width,maxHeight);

                    customeView.frame = CGRectMake(CGRectGetMinX(customeView.frame), CGRectGetMinY(customeView.frame),CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - (kX_GAP * 2 + kH_LABLE + kH_BTN));
                    
                    customeView.clipsToBounds = YES;
                    for (UIView * view in customeView.subviews) {
                        
                        if (CGRectGetHeight(view.frame) > CGRectGetHeight(customeView.frame)) {
                            
                            view.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(customeView.frame));
                        }
                        
                    }
                    
                }

            }else{
                
                self.frame = CGRectMake(0, 0, self.frame.size.width,kX_GAP + titleSize.height + 5 + msgSize.height + btnSize.height);
            }
            
            
            for (int i = 0; i < btnCount; i++) {
                
                [self addBtnWithFrame:CGRectMake( self.frame.size.width/btnCount * i, self.frame.size.height - kH_BTN, self.frame.size.width/btnCount, kH_BTN) title:[buttonTitles objectAtIndex:i] tag:(170+i)];
            }
            
        }
        
        self.backgroundColor = UIColor.whiteColor;
        self.center = [[[[UIApplication sharedApplication]windows]firstObject]center];
        
        self.delegate = delegate;//代理
        
    }
    
    return self;
}

//添加活动指示器背景图
-(void)addActivityBackgroundView{
    
    if (_activityOnView == nil) {
        _activityOnView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _activityOnView.backgroundColor = [UIColor blackColor];
        _activityOnView.alpha = 0.1f;
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:_activityOnView];
        return;
    }
    if (![_activityOnView isDescendantOfView:[[UIApplication sharedApplication] keyWindow]]) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:_activityOnView];
    }
}
//移除活动指示器背景图
-(void)removeActivityBackgroundView{
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cancelBackgroundView" object:nil];
    if (_activityOnView) {
        if ([_activityOnView isDescendantOfView:[[UIApplication sharedApplication] keyWindow]]) {
            [_activityOnView removeFromSuperview];
        }
        _activityOnView=nil;
    }
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
