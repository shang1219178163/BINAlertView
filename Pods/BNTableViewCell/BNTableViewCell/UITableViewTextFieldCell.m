//
//  UITableViewTextFieldCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewTextFieldCell.h"

#import "BNGloble.h"
#import "BNTextField.h"
#import "UIView+Helper.h"
#import "NSString+Helper.h"
#import "NSObject+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


/**
文字+文字(textField)
 */
@implementation UITableViewTextFieldCell

- (void)dealloc{
    [self.labelLeft removeObserver:self forKeyPath:@"text"];
    [self.textField removeObserver:self forKeyPath:@"enabled"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.labelLeft];
        [self.contentView addSubview:self.textField];
        
        [self.labelLeft addObserver:self forKeyPath:@"text" options: NSKeyValueObservingOptionNew context:nil];
        [self.textField addObserver:self forKeyPath:@"enabled" options: NSKeyValueObservingOptionNew context:nil];
        self.textField.placeholder = @"请输入";
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.delegate = self;
        
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
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kX_GAP);
        make.size.equalTo(CGSizeMake(self.labelLeft.sizeWidth, 35));
    }];
    
     [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelLeft);
         make.left.equalTo(self.labelLeft.right).offset(kPadding);
         make.right.equalTo(self.contentView).offset(-kX_GAP);
        make.height.equalTo(self.labelLeft);
     }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(self, textField);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - -

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.labelLeft.attributedText = [self.labelLeft.text toAsterisk];
    }
    if ([keyPath isEqualToString:@"enabled"]) {
        
        if ([change[NSKeyValueChangeNewKey] boolValue]) {
            self.textField.placeholder = @"请输入";
            
            self.textField.layer.borderWidth = kW_LayerBorder;
            self.textField.layer.borderColor = UIColor.lineColor.CGColor;
        } else {
            self.textField.placeholder = @"";
            self.textField.text = [self.textField.text validObject] ? self.textField.text :  kNIl_TEXT;
            
            self.textField.layer.borderWidth = kW_LayerBorder;
            self.textField.layer.borderColor = UIColor.clearColor.CGColor;
            
        }
    }
}

#pragma mark - -layz



@end

