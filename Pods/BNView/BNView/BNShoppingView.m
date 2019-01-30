//
//  BINShoppingCartBottomView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BNShoppingView.h"

#import "BNGloble.h"
#import "BNCategory.h"

@implementation BNShoppingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {        
        [self addSubview:self.btnRadio];
        [self addSubview:self.btnDoIt];

        [self addSubview:self.labPriceAll];
        
        [self getViewLayer];

        self.backgroundColor = UIColor.whiteColor;
        self.backgroundColor = UIColor.whiteColor;

    }
    return self;
}

- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFZ_Third] range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attString addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[string rangeOfString:textTaps[i]]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFZ_Third] range:[string rangeOfString:textTaps[i]]];
        
    }
    return attString;
}

-(void)handleActionBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(shoppingCartView:sender:)]) {
        [self.delegate shoppingCartView:self sender:sender];
        
    }
    
    if (self.block) {
        self.block(self, sender);
    }
}

-(UIButton *)btnDoIt{
    if (!_btnDoIt) {
        CGRect rectBtn = CGRectMake(kScreenWidth - kScreenWidth/3.0, 0, kScreenWidth/3.0, CGRectGetHeight(self.frame));
        _btnDoIt = [UIView createBtnRect:rectBtn title:@"下一步" font:16 image:nil tag:kTAG_BTN+1 type:@1];
        [_btnDoIt addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDoIt;
}

-(UIButton *)btnRadio{
    if (!_btnRadio) {
        _btnRadio = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRadio.frame = CGRectMake(kX_GAP, kY_GAP, 65, kH_LABEL);

        [_btnRadio setImage:[UIImage imageNamed:@"img_btn_unSelect.png"] forState:UIControlStateNormal];
        [_btnRadio setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateSelected];
        [_btnRadio setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateHighlighted];

        _btnRadio.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_btnRadio setTitle:@"全选" forState:UIControlStateNormal];
        [_btnRadio setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _btnRadio.titleLabel.font = [UIFont systemFontOfSize:kFZ_Second];

        _btnRadio.tag = kTAG_BTN;
        [_btnRadio addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRadio;
}


-(UILabel *)labPriceAll{
    if (!_labPriceAll) {
        NSString * titleSub = @"0个订单  共0元";
        CGRect rectSub = CGRectMake(CGRectGetMidX(self.btnRadio.frame), CGRectGetMaxY(self.btnRadio.frame), CGRectGetMinX(self.btnDoIt.frame) - CGRectGetMidX(self.btnRadio.frame), kH_LABEL);
        _labPriceAll = [UIView createLabelRect:rectSub text:titleSub font:16 tag:kTAG_LABEL type:@2];
        
    }
    return _labPriceAll;
}


@end
