//
//  BNListChooseView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNListChooseView.h"

#import "BNGloble.h"
#import "UIView+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation BNListChooseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {        
        [self addSubview:self.labelLeft];
        [self addSubview:self.textField];

        self.textField.placeholder = @"请选择";
        self.textField.textAlignment = NSTextAlignmentCenter;
        
        self.textField.rightView = [self.textField asoryView:kIMG_arrowDown];
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.textField.enabled = false;
//
        @weakify(self);
        [self addGestureTap:^(UIGestureRecognizer *sender) {
            @strongify(self);
            [UIApplication.sharedApplication.keyWindow endEditing:true];

            [self.pickerView show];
        }];
        
        [self setupConstraint];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    [self.labelLeft sizeToFit];
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kX_GAP);
        make.size.lessThanOrEqualTo(CGSizeMake(self.labelLeft.sizeWidth, kSizeArrow.height));
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelLeft);
        make.left.equalTo(self.labelLeft.right).offset(kPadding);
        make.right.equalTo(self).offset(-kX_GAP);
        make.height.equalTo(self.labelLeft);
    }];
}

#pragma mark - lazy

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [self createLabelRect:CGRectZero text:@"修改名称:" font:16 tag:0];
    }
    return _labelLeft;
}

-(BNTextField *)textField{
    if (!_textField) {
        _textField = [UIView createTextFieldRect:CGRectZero text:@"" placeholder:nil font:kFZ_Second textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault];
        _textField.tag = kTAG_TEXTFIELD;
    }
    return _textField;
}

-(BNPickerListView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[BNPickerListView alloc]initWithFrame:CGRectZero];
        @weakify(self);
        _pickerView.block = ^(BNPickerListView *view, NSIndexPath *indexP, NSString *text) {
            @strongify(self);
            self.textField.text = text;
        };
    }
    return _pickerView;
}

- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text font:(CGFloat)font tag:(NSInteger)tag{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.font = [UIFont systemFontOfSize:font];
    view.textAlignment = NSTextAlignmentCenter;
    view.userInteractionEnabled = true;
    view.numberOfLines = 1;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.adjustsFontSizeToFitWidth = YES;
    //        label.backgroundColor = UIColor.greenColor;
    
    view.text = text;
    view.tag = tag;
    return view;
}


@end
