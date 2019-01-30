//
//  UITableViewPickerViewCell.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UITableViewPickerViewCell.h"

#import "NSString+Helper.h"

@implementation UITableViewPickerViewCell

-(void)dealloc{
    [self.chooseView.labelLeft removeObserver:self forKeyPath:@"text" context:nil];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.chooseView];
        
        [self.chooseView.labelLeft addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.chooseView.labelLeft.attributedText = [self.chooseView.labelLeft.text toAsterisk];;
        
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.chooseView.frame = self.contentView.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BNListChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[BNListChooseView alloc]initWithFrame:self.bounds];
        _chooseView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    }
    return _chooseView;
}

@end
