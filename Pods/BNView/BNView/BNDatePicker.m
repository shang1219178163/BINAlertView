//
//  BNDatePicker.m
//  BINView
//
//  Created by BIN on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BNDatePicker.h"

#import "BNGloble.h"

@interface BNDatePicker()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;// 中间标题Label;

@end

@implementation BNDatePicker

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle{
    self = [super init];
    if (self) {
        self.datePickerMode = UIDatePickerModeDate;
        self.minimumDate = NSDate.distantPast;
        self.maximumDate = NSDate.distantFuture;
        self.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        // config maskView's frame
        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = UIColor.blackColor;
        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.maskView addGestureRecognizer:tap];
        
        // custom DatePicker height
        CGFloat lineHeight = 0.5;
        CGFloat containViewHeight = kH_PickerView + kH_NaviagtionBar + lineHeight;
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(window.frame) - containViewHeight, CGRectGetWidth(window.frame), containViewHeight)];
        self.containView.backgroundColor = UIColor.lightGrayColor;
        
        //config UIToolbar
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), kH_NaviagtionBar)];
        toolBar.tintColor = UIColor.blackColor;//字体颜色
        toolBar.barTintColor = UIColor.whiteColor;//背景
        
        NSString *cancelTitle = [NSString stringWithFormat:@"   %@",cancelBtnTitle];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:cancelTitle style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        [cancelItem setTintColor:UIColor.redColor];

        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSString *confirmTitle = [NSString stringWithFormat:@"%@    ",confirmBtnTitle];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:confirmTitle style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
        [confirmItem setTintColor:UIColor.blackColor];

        NSArray *items = @[cancelItem,flexItem,confirmItem];
        [toolBar setItems:items];
        [self.containView addSubview:toolBar];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(toolBar.frame), CGRectGetWidth(self.containView.frame), lineHeight)];
        lineView.backgroundColor = UIColor.lightGrayColor;
        [self.containView addSubview:lineView];
        
        // config system DatePicker frame;
        self.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), CGRectGetWidth(self.containView.frame), kH_PickerView);
        self.backgroundColor = UIColor.whiteColor;
        [self.containView addSubview:self];
        
        
        // config titleLabel
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame)/3.0, kH_NaviagtionBar)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = UIColor.clearColor;
        [toolBar addSubview:self.titleLabel];
        self.titleLabel.center = toolBar.center;
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)show{
    [UIApplication.sharedApplication.keyWindow endEditing:true];
    
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.containView];
    
    self.containView.transform = CGAffineTransformMakeTranslation(self.containView.transform.tx, self.containView.transform.ty + CGRectGetHeight(self.containView.frame));
    
    [UIView animateWithDuration:kDurationShow animations:^{
        self.maskView.alpha = 0.5;
        self.containView.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}

-(void)dismiss{
    [UIView animateWithDuration:kDurationShow animations:^{
        self.maskView.alpha = 0;
        self.containView.transform = CGAffineTransformMakeTranslation(self.containView.transform.tx, self.containView.transform.ty + CGRectGetHeight(self.containView.frame));

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
    [self dismiss];
}


-(void)confirm{
    if (self.block) {
        self.block(self, 1);
    }
    [self dismiss];
}



@end
