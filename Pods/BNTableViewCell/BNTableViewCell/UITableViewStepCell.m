//
//  UITableViewStepCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewStepCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIView+Helper.h"
#import "NSString+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

/**
 文字+btn
 */
@implementation UITableViewStepCell

- (void)dealloc
{
    [self.labelLeft removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.labelLeft];
        [self.contentView addSubview:self.ppBtn];
        
        [self.labelLeft addObserver:self forKeyPath:@"text" options: NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

#pragma mark -observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.labelLeft.attributedText = [self.labelLeft.text toAsterisk];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    [self.labelLeft sizeToFit];
    self.labelLeft.size = CGSizeMake(self.labelLeft.sizeWidth, 35);
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kX_GAP);
        make.size.equalTo(self.labelLeft.size);
    }];
    
    [self.ppBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.top.equalTo(self.labelLeft);
        make.right.equalTo(self.contentView).offset(-kX_GAP);
        make.width.equalTo(120);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(PPNumberButton *)ppBtn{
    if (!_ppBtn) {
        _ppBtn = [PPNumberButton numberButtonWithFrame:CGRectZero];
        //        _ppBtn.delegate = self;
        // 初始化时隐藏减按钮
        //        _ppBtn.decreaseHide = YES;
        _ppBtn.increaseImage = [UIImage imageNamed:kIMG_elemetInc];
        _ppBtn.decreaseImage = [UIImage imageNamed:kIMG_elemetDec];

        _ppBtn.shakeAnimation = YES;
        _ppBtn.tag = kTAG_BTN;
    }
    return _ppBtn;
}


@end
