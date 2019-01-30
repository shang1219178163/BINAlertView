//
//  UITableViewSliderCell.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UITableViewSliderCell.h"
#import "NSString+Helper.h"

@implementation UITableViewSliderCell

-(void)dealloc{
    [self.sliderView.labelLeft removeObserver:self forKeyPath:@"text" context:nil];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.sliderView];
        
        [self.sliderView.labelLeft addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.sliderView.labelLeft.attributedText = [self.sliderView.labelLeft.text toAsterisk];;
        
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.sliderView.frame = self.contentView.bounds;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BNSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[BNSliderView alloc]initWithFrame:self.bounds];
        _sliderView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    }
    return _sliderView;
}

@end
