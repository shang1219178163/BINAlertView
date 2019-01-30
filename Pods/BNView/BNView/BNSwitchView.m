//
//  BNSwitchView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNSwitchView.h"

#import "BNGloble.h"
#import "UIView+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation BNSwitchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labelLeft];
        [self addSubview:self.switchCtl];
        
        self.ctlAlignment = NSTextAlignmentRight;
        [self setupConstraint];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [self setupConstraint];
}

- (void)setupConstraint{
    [self.labelLeft sizeToFit];
    self.labelLeft.size = CGSizeMake(self.labelLeft.sizeWidth, 35);
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kX_GAP);
        make.size.equalTo(self.labelLeft.size);
    }];
    
    CGFloat width = self.sizeWidth - self.labelLeft.maxX - kX_GAP;
    CGFloat ctlWidth = width*0.7;
    switch (self.ctlAlignment) {
        case NSTextAlignmentLeft:
        {
            [self.switchCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self.labelLeft.right).offset((width - ctlWidth)*0.5);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
        default:
        {
            [self.switchCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-kX_GAP);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
    }
    
}

#pragma mark - lazy

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [self createLabelRect:CGRectZero text:@"是否确认:" tag:0];
    }
    return _labelLeft;
}


- (UISwitch *)switchCtl{
    if (!_switchCtl) {
        _switchCtl = [UIView createSwitchRect:CGRectZero isOn:false];
    }
    return _switchCtl;
}

- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.font = [UIFont systemFontOfSize:16];
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
