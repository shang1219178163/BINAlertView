//
//  BNSearchView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNSearchView.h"

#import "BNGloble.h"
#import "UIView+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation BNSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textField];
        [self addSubview:self.btn];
      
        self.queryStr = @"";
        self.textField.placeholder = @"请输入关键字";
        self.textField.delegate = self;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kX_GAP);
        make.size.equalTo(CGSizeMake(60, self.sizeHeight - kY_GAP*2));
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kX_GAP);
        make.right.equalTo(self.btn.left).offset(kPadding);
        make.height.equalTo(self.btn);
    }];
    
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        self.queryStr = [self.queryStr substringToIndex:self.queryStr.length - 1];
    } else {
        self.queryStr = [textField.text stringByAppendingString:string];
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - lazy

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIView createBtnRect:CGRectZero title:@"搜索" font:16 image:nil tag:kTAG_BTN type:@7];
    }
    return _btn;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [UIView createTextFieldRect:CGRectZero text:@"" tag:kTAG_TEXTFIELD];
        _textField.returnKeyType = UIReturnKeySearch;

    }
    return _textField;
}


@end
