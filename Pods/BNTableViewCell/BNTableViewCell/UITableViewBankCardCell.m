//
//  UITableViewBankCardCell.m
//  YHKLB
//
//  Created by zxl on 2017/12/21.
//  Copyright © 2017年 EM. All rights reserved.
//

#import "UITableViewBankCardCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"

@interface UITableViewBankCardCell ()
 
@end

@implementation UITableViewBankCardCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
        [self makeConstraint];
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;

    }
    return self;
}
-(void)setUpViews{
//    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.shadowBgView];
    [self.shadowBgView addSubview:self.cardBgView];
    [self.cardBgView addSubview:self.miniLogBgView];
    [self.cardBgView addSubview:self.miniLogo];
    [self.cardBgView addSubview:self.bankNameLabel];
    [self.cardBgView addSubview:self.marketValueLabel];
    [self.cardBgView addSubview:self.logoNewImageView];
//    self.contentView.backgroundColor = UIColor.clearColor;
}
- (void)makeConstraint{
//    [self.shadowBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView);
//        make.left.equalTo(self.contentView).offset(12.5);
//        make.right.equalTo(self.contentView).offset(-12.5);
//        make.height.equalTo(100);
//    }];
//    [self.cardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.shadowBgView);
//        make.left.equalTo(self.shadowBgView);
//        make.right.equalTo(self.shadowBgView);
//        make.height.equalTo(100);
//    }];
//    [self.miniLogBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.cardBgView).offset(29);
//        make.left.equalTo(self.cardBgView).offset(20);
//        make.size.equalTo(CGSizeMake(42, 42));
//    }];
//    [self.miniLogo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.miniLogBgView);
//        make.size.equalTo(CGSizeMake(32, 32));
//    }];
//    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(30);
//        make.left.equalTo(self.miniLogo.mas_right).offset(10);
//        make.right.equalTo(self.cardBgView).offset(-15);
//        make.height.equalTo(16);
//    }];
//    [self.marketValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bankNameLabel.mas_bottom).offset(6);
//        make.left.right.equalTo(self.bankNameLabel);
//        make.height.equalTo(20);
//    }];
//    [self.logoNewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.cardBgView);
//        make.right.equalTo(self.cardBgView);
//        make.size.equalTo(CGSizeMake(30, 30));
//    }];
}
-(UIView *)shadowBgView{
    if (!_shadowBgView) {
        _shadowBgView = [[UIView alloc] init];
        _shadowBgView.backgroundColor = UIColor.clearColor;
        _shadowBgView.layer.shadowOffset = CGSizeMake(0, -2);
        _shadowBgView.layer.shadowOpacity = 0.2;
        _shadowBgView.layer.shadowRadius = 4;
    }
    return _shadowBgView;
}
-(UIView *)cardBgView{
    if (!_cardBgView) {
        _cardBgView = [[UIView alloc] init];
        [_cardBgView.layer addSublayer:self.gradientLayer];
        _cardBgView.layer.shadowColor = UIColor.blackColor.CGColor;
        _cardBgView.layer.cornerRadius = 7.0f;
        _cardBgView.layer.masksToBounds = YES;
    }
    return _cardBgView;
}
-(UIView *)miniLogBgView{
    if (!_miniLogBgView) {
        _miniLogBgView = [[UIView alloc] init];
        _miniLogBgView.backgroundColor = UIColor.whiteColor;
        _miniLogBgView.layer.cornerRadius = 21.0f;
        _miniLogBgView.layer.masksToBounds = YES;
    }
    return _miniLogBgView;
}
-(UIImageView *)miniLogo{
    if (!_miniLogo) {
        _miniLogo = [[UIImageView alloc] init];
        _miniLogo.image = [UIImage imageNamed:@"bankVerify_cmb"];
    }
    return _miniLogo;
}
-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] init];
        _bankNameLabel.textAlignment = NSTextAlignmentLeft;
        _bankNameLabel.font = [UIFont systemFontOfSize:16.f];
        _bankNameLabel.textColor = UIColor.grayColor;
        _bankNameLabel.text = @"招商银行";
    }
    return _bankNameLabel;
}
-(UILabel *)marketValueLabel{
    if (!_marketValueLabel) {
        _marketValueLabel = [[UILabel alloc] init];
        _marketValueLabel.font = [UIFont systemFontOfSize:15.f];
        _marketValueLabel.textColor = UIColor.greenColor;
        _marketValueLabel.adjustsFontSizeToFitWidth = YES;
        _marketValueLabel.textAlignment = NSTextAlignmentLeft;
        _marketValueLabel.attributedText = [self bankCardNoAttriStr];
    }
    return _marketValueLabel;
}

-(UIImageView *)logoNewImageView{
    if (!_logoNewImageView) {
        _logoNewImageView = [[UIImageView alloc] init];
    }
    return _logoNewImageView;
}
- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = CAGradientLayer.layer;
        
        _gradientLayer.colors = @[(__bridge id)UIColor.randomColor.CGColor, (__bridge id)UIColor.randomColor.CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
        _gradientLayer.frame = CGRectMake(0, 0,kScreenWidth - 25, 100);
    }
    return _gradientLayer;
}

-(NSMutableAttributedString *)bankCardNoAttriStr{
    NSString *bankcardnoSub = @"7705";
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"＊＊＊＊  ＊＊＊＊  ＊＊＊＊ %@",bankcardnoSub]];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:[attriStr.string rangeOfString:@"＊＊＊＊  ＊＊＊＊  ＊＊＊＊"]];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.f] range:[attriStr.string rangeOfString:bankcardnoSub]];
    return attriStr;
}

@end
