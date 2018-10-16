//
//  BINShareView.m
//  ShareInfo
//
//  Created by hsf on 2017/9/1.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "BINShareView.h"

#import "BINShareModelView.h"
#import "BINShareModel.h"

#define kTAG_VIEW 1000

#define kScreenWidth		[[UIScreen mainScreen] bounds].size.width
#define kScreenHeight		[[UIScreen mainScreen] bounds].size.height

//#define kC_SHAREVIEW_BGCOLOR   [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1]
#define kC_WINDOW_COLOR        [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]

static const NSInteger rowCount = 4;
static const CGFloat animationDuration = 0.25;

static const CGFloat H_LabTitle = 35;
static const CGFloat W_LabTitle = 60;
static const CGFloat XGap = 10;

static const CGFloat H_BtnCancell = 45;

static const CGFloat H_ModelView = 70;
static const CGFloat padding = 5;

@interface BINShareView ()
//	整个底部分享面板的 backgroundView
@property (nonatomic, strong) UIView   *backgroundView;
//	分享面板View(除了btn以外的View)
@property (nonatomic, strong) UIView   *sheetView;
//	头部提示Label
@property (nonatomic, strong) UILabel  *topLab;
@property (nonatomic, copy)   NSString *topTitle;//@""空字符会隐藏title

@property (nonatomic, strong) UIView   *lineView;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, copy)   NSString *btnTitle;//@""空字符会隐藏btn

@property (nonatomic, strong) NSArray  *shareModelList;


@end

@implementation BINShareView

+ (BINShareView *)shareViewWithShareModels:(NSArray *)shareModels topTitle:(NSString *)topTitle btnTitle:(NSString *)btnTitle{
    
    BINShareView *view = [[self alloc]initWithShareModels:shareModels topTitle:topTitle btnTitle:(NSString *)btnTitle];
    return view;
}

- (instancetype)initWithShareModels:(NSArray *)shareModels topTitle:(NSString *)topTitle btnTitle:(NSString *)btnTitle{
    
    self = [super init];
    if (self) {
        self.shareModelList = shareModels;
        self.topTitle = topTitle;
        self.btnTitle = btnTitle;
                
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        //	背景，带灰度
        self.backgroundColor = kC_WINDOW_COLOR;
        //	可点击
        self.userInteractionEnabled = YES;
        //	点击背景，收起底部分享面板，移除本视图
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        //	加载分享面板
        [self loadUIConfigNew];
    }
    return self;
}

- (void)loadUIConfigNew {
    
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.sheetView];
    if (self.btnTitle.length != 0)[self.backgroundView addSubview:self.btnCancel];
    
//    self.backgroundView.backgroundColor = [UIColor cyanColor];
//    self.sheetView.backgroundColor = [UIColor greenColor];
    //    self.cancelBtn.backgroundColor = [UIColor redColor];
    
    self.topLab.text = self.topTitle;
    //	按钮
    for (NSInteger i = 0; i < self.shareModelList.count; i++) {
        BINShareModel * shareModel = self.shareModelList[i];
        
        CGFloat x = CGRectGetWidth(self.backgroundView.frame) / rowCount * ( i % rowCount);
        CGFloat y = (self.topTitle.length == 0 ? 0.0 : H_LabTitle) + (i / rowCount) * (H_ModelView + padding);
        CGFloat w = CGRectGetWidth(self.backgroundView.frame) / rowCount;
        CGFloat h = H_ModelView;
        
        //        CGRect frame =  CGRectMake(x, y, w, h);
        BINShareModelView * modelView = [[BINShareModelView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        modelView.btn.tag = kTAG_VIEW + i;
        
        modelView.titleLab.text = shareModel.title;
        [modelView.btn setImage:[UIImage imageNamed:shareModel.btnImageNomol] forState:UIControlStateNormal];
        [modelView.btn setImage:[UIImage imageNamed:shareModel.btnImageHighlighted] forState:UIControlStateHighlighted];
        
        [modelView.btn addTarget:self action:@selector(shareBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.sheetView addSubview:modelView];
        
    }
    //	弹出
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundView.frame = CGRectMake(0, kScreenHeight - CGRectGetHeight(self.backgroundView.frame), kScreenWidth, CGRectGetHeight(self.backgroundView.frame));
    }];
  
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];

}

- (void)shareBtnPress:(UIButton *)sender{
    
    [self tappedCancel];
    if (self.actionWithBlock) {
        self.actionWithBlock(sender.tag - kTAG_VIEW);
    }
}


- (UIView *)backgroundView {
    
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        
        //	根据图标个数，计算行数，计算 backgroundView 的高度
        NSInteger rows;
        if (self.shareModelList.count % rowCount == 0) {
            rows = self.shareModelList.count / rowCount;
            
        } else {
            rows = self.shareModelList.count / rowCount + 1;
            
        }

        _backgroundView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, (self.btnTitle.length == 0 ? 0 : H_BtnCancell) + (self.topTitle.length == 0 ? 0 : H_LabTitle) + (H_ModelView + padding) * rows);
    }
    return _backgroundView;
}

-(UIView *)sheetView{
    
    if (_sheetView == nil) {
        
        _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backgroundView.frame), CGRectGetHeight(_backgroundView.frame) - (self.btnTitle.length == 0 ? 0.0 :H_BtnCancell))];
        _sheetView.backgroundColor = UIColor.whiteColor;
//        _sheetView.alpha = 0.8;
        
        //	如果有标题，添加标题
        if (self.topTitle.length != 0) {
            [_sheetView addSubview:self.lineView];
            [_sheetView addSubview:self.topLab];
        }
        
    }
    return _sheetView;
}

-(UILabel *)topLab
{
    if (_topLab == nil) {
        _topLab = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(_backgroundView.frame) - W_LabTitle)/2.0, 0, W_LabTitle, H_LabTitle)];
        //	默认标题
        _topLab.text = @"分享至";
        _topLab.font = [UIFont systemFontOfSize:15];
        _topLab.textColor = [UIColor blackColor];
        _topLab.backgroundColor = UIColor.whiteColor;

//        _topLab.backgroundColor = [UIColor yellowColor];
        _topLab.textAlignment = NSTextAlignmentCenter;
    }
    return _topLab;
}

-(UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(XGap, (H_LabTitle - 1)/2.0, CGRectGetWidth(_backgroundView.frame) - XGap*2 , 1)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
//        _lineView.backgroundColor = [UIColor redColor];

    }
    return _lineView;
}

-(UIButton *)btnCancel{
    
    if (_btnCancel == nil) {
        
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel.frame = CGRectMake(0, CGRectGetHeight(_backgroundView.frame) - H_BtnCancell, CGRectGetWidth(_backgroundView.frame), H_BtnCancell);
        //	取消按钮
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        _btnCancel.backgroundColor = UIColor.whiteColor;
        [_btnCancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //	点击按钮，取消，收起面板，移除视图
        [_btnCancel addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnCancel;
}

/**
 点击取消
 */
- (void)tappedCancel {
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.backgroundView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end

