//
//  BINPickerView.m
//  BINView
//
//  Created by hsf on 2017/9/12.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BINPickerView.h"

#define kH_NaviagtionBarHeight 44
#define kH_PickerViewHeight 180

@interface BINPickerView()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;// 中间标题Label;

@end

@implementation BINPickerView

-(id)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmButtonTitle:(NSString *)confirmBtnTitle
{
    self = [super init];
    if (self) {
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
        [self.maskView addGestureRecognizer:tap];
        
        // custom DatePicker height
        CGFloat lineHeight = 1;
        CGFloat height = kH_PickerViewHeight + kH_NaviagtionBarHeight + lineHeight;
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
        

        // config titleLabel
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame)/3.0, kH_NaviagtionBarHeight)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [toolBar addSubview:self.titleLabel];
        self.titleLabel.center = toolBar.center;
        
        // config system DatePicker frame;
        self.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), CGRectGetWidth(self.containView.frame), kH_PickerViewHeight);
        self.showsSelectionIndicator = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self.containView addSubview:self];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    
}

-(void)show
{
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

-(void)dismissPickerView
{
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
-(void)cancel
{
    if (self.blockPickView) {
        self.blockPickView(self, 0);
    }
    [self dismissPickerView];
}


-(void)confirm
{
    if (self.blockPickView) {
        self.blockPickView(self, 1);
    }
    [self dismissPickerView];
}

-(void)actionWithBlock:(BlockPickView)blockPickView{
    
    self.blockPickView = blockPickView;
    
}

//-(UIButton *)btnCancell{
//    
//    if (!_btnCancell) {
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, 0, 35, 30);
//        btn.exclusiveTouch = YES;
//        [btn setTitle:@"取消" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return _btnCancell;
//    
//
//}
//
//-(UIButton *)btnConfirm{
//    
//    if (!_btnConfirm) {
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, 0, 35, 30);
//        btn.exclusiveTouch = YES;
//        [btn setTitle:@"确定" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
//
//    }
//    return _btnConfirm;
//}


@end
