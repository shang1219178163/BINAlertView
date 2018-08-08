//
//  BINDataPicker.m
//  BINView
//
//  Created by hsf on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BN_DatePicker.h"

#define kH_NaviagtionBarHeight 44
#define kDatePickerHeight 180


@interface BN_DatePicker()

@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) UIView *containView;
@property(nonatomic,strong,readwrite) UILabel *titleLabel;// 中间标题Label;

@end

@implementation BN_DatePicker

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle{
    self = [super init];
    if (self) {
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        // config maskView's frame
        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker)];
        [self.maskView addGestureRecognizer:tap];
        
        // custom DatePicker height
        CGFloat lineHeight = 1;
        CGFloat height = kDatePickerHeight + kH_NaviagtionBarHeight + lineHeight;
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(window.frame), CGRectGetWidth(window.frame), height)];
        self.containView.backgroundColor = [UIColor lightGrayColor];
        
        //config UIToolbar
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), kH_NaviagtionBarHeight)];
        toolBar.tintColor = [UIColor blackColor];//字体颜色
        toolBar.barTintColor = [UIColor whiteColor];//背景
        
        NSString *cancelTitle = [NSString stringWithFormat:@"   %@",cancelBtnTitle];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:cancelTitle style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        [cancelItem setTintColor:[UIColor redColor]];

        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSString *confirmTitle = [NSString stringWithFormat:@"%@    ",confirmBtnTitle];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:confirmTitle style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
        [confirmItem setTintColor:[UIColor blackColor]];

        NSArray *items = @[cancelItem,flexItem,confirmItem];
        [toolBar setItems:items];
        [self.containView addSubview:toolBar];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kH_NaviagtionBarHeight, CGRectGetWidth(self.containView.frame), lineHeight)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.containView addSubview:lineView];
        
        // config system DatePicker frame;
        self.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), CGRectGetWidth(self.containView.frame), kDatePickerHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self.containView addSubview:self];
        
        
        // config titleLabel
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame)/3.0, kH_NaviagtionBarHeight)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [toolBar addSubview:self.titleLabel];
        self.titleLabel.center = toolBar.center;
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    
}

-(void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.maskView];
    [window addSubview:self.containView];
    
    CGRect tempFrame = self.containView.frame;
    tempFrame.origin.y = CGRectGetMinY(tempFrame) - CGRectGetHeight(tempFrame);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.maskView.alpha = 0.5;
        self.containView.frame = tempFrame;
        
    } completion:nil];
}


#pragma mark UITapGestureRecognizer Sel

-(void)dismissDatePicker{
    CGRect tempFrame = self.containView.frame;
    tempFrame.origin.y = CGRectGetMinY(tempFrame) + CGRectGetHeight(tempFrame);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.maskView.alpha = 0;
        self.containView.frame = tempFrame;
        
    } completion:^(BOOL finished) {
        [self.containView removeFromSuperview];
        [self.maskView removeFromSuperview];
        
    }];
}

#pragma mark Cancel and Confirm
-(void)cancel{
    if (self.block) {
        self.block(self, 0);
    }
    [self dismissDatePicker];
}


-(void)confirm{
    if (self.block) {
        self.block(self, 1);
    }
    [self dismissDatePicker];
}


@end
