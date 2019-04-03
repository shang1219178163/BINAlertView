//
//  BNPickerView.m
//  BINView
//
//  Created by BIN on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BNPickerView.h"

#import "BNGloble.h"
#import "BNCategory.h"
#import "Masonry.h"

@interface BNPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *toobarView;
@property (nonatomic, strong) UIButton *btnSure;
@property (nonatomic, strong) UIButton *btnCancell;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) CGFloat containViewHeight;

@end

/**
 改变代理方法指向,设置自定义数据源
 */
@implementation BNPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = UIScreen.mainScreen.bounds;
        [self addSubview:self.maskView];
        [self addSubview:self.containView];
        
        self.containViewHeight = kH_PickerView+kH_NaviagtionBar;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.containView.superview);
        make.height.equalTo(self.containViewHeight);
    }];
    
    [self.toobarView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.toobarView.superview);
        make.height.equalTo(kH_NaviagtionBar);
    }];
    
    [self.btnCancell makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCancell.superview).offset(kPadding);
        make.left.equalTo(self.btnCancell.superview).offset(kX_GAP);
        make.bottom.equalTo(self.btnCancell.superview).offset(-kPadding);
        make.width.equalTo(60);
    }];
    
    [self.btnSure makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnSure.superview).offset(kPadding);
        make.right.equalTo(self.btnSure.superview).offset(-kX_GAP);
        make.bottom.equalTo(self.btnSure.superview).offset(-kPadding);
        make.width.equalTo(60);
    }];
    
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label.superview);
        make.left.equalTo(self.btnCancell.right).offset(kPadding);
        make.right.equalTo(self.btnSure.left).offset(-kPadding);
    }];
    
    [self.lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toobarView.bottom);
        make.left.right.equalTo(self.lineView.superview);
        make.height.equalTo(kH_LINE_VIEW);
    }];
    
    [self.pickerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.bottom);
        make.left.right.bottom.equalTo(self.pickerView.superview);
    }];
    
    [self.maskView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.maskView.superview);
        make.bottom.equalTo(self.containView.top);
    }];
}

-(void)show{
    [UIApplication.sharedApplication.keyWindow endEditing:true];
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    self.containView.transform = CGAffineTransformMakeTranslation(self.containView.transform.tx, self.containView.transform.ty + self.containViewHeight);

    [UIView animateWithDuration:kDurationShow animations:^{
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        self.containView.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}

-(void)dismiss{
    [UIView animateWithDuration:kDurationShow animations:^{
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0];
        self.containView.transform = CGAffineTransformMakeTranslation(self.containView.transform.tx, self.containView.transform.ty + self.containViewHeight);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

#pragma mark - - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 9;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *info = [NSString stringWithFormat:@"%@-%@",@(component),@(row)];
    return info;
}


#pragma mark - funtions
-(void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
}

#pragma mark - -lazy

-(UIView *)maskView{
    if (!_maskView) {
        _maskView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
            [view addGestureRecognizer:tap];
            
            view;
        });
    }
    return _maskView;
}

-(UIButton *)btnSure{
    if (!_btnSure) {
        _btnSure = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:kActionTitle_Sure forState:UIControlStateNormal];
            [view setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            [view addActionHandler:^(UIControl * _Nonnull control) {
                if (self.block) {
                    self.block(self.pickerView, 1);
                }
                [self dismiss];
            } forControlEvents:UIControlEventTouchUpInside];
            view;
        });
    }
    return _btnSure;
}

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
            view.font = [UIFont systemFontOfSize:17];
            view.textColor = UIColor.blackColor;
            view.textAlignment = NSTextAlignmentCenter;
            
            view.text = @"请选择";
            view.numberOfLines = 0;
            view.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
            view;
        });
    }
    return _label;
}

-(UIButton *)btnCancell{
    if (!_btnCancell) {
        _btnCancell = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:kActionTitle_Cancell forState:UIControlStateNormal];
            [view setTitleColor:UIColor.redColor forState:UIControlStateNormal];
            [view addActionHandler:^(UIControl * _Nonnull control) {
                if (self.block) {
                    self.block(self.pickerView, 0);
                }
                [self dismiss];
            } forControlEvents:UIControlEventTouchUpInside];
            view;
        });
    }
    return _btnCancell;
}

-(UIView *)toobarView{
    if (!_toobarView) {
        _toobarView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = UIColor.whiteColor;
            
            [view addSubview:self.btnCancell];
            [view addSubview:self.label];
            [view addSubview:self.btnSure];

            view;
        });
    }
    return _toobarView;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = ({
            UIPickerView * view = [[UIPickerView alloc]initWithFrame:CGRectZero];
            view.dataSource = self;
            view.delegate = self;
            view.showsSelectionIndicator = YES;
            
            view.backgroundColor = UIColor.whiteColor;
            view;
        });
    }
    return _pickerView;
}

-(UIView *)containView{
    if (!_containView) {
        _containView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = UIColor.whiteColor;

            [view addSubview:self.toobarView];
            [view addSubview:self.lineView];
            [view addSubview:self.pickerView];

            view;
        });
    }
    return _containView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
            
            view;
        });
    }
    return _lineView;
}

@end
