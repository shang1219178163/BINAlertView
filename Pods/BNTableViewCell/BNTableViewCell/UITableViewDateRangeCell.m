//
//  UITableViewDateRangeCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewDateRangeCell.h"

#import "BNGloble.h"
#import "NSString+Helper.h"

/**
 起止时间选择
 */
@implementation UITableViewDateRangeCell

-(void)dealloc{
    [self.dateRangeView.labelLeft removeObserver:self forKeyPath:@"text" context:nil];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.dateRangeView];
        
        [self.dateRangeView.labelLeft addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
      
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.dateRangeView.labelLeft.attributedText = [self.dateRangeView.labelLeft.text toAsterisk];;
            
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.dateRangeView.frame = self.contentView.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark - -layz

-(BNDateRangeView *)dateRangeView{
    if (!_dateRangeView) {
        _dateRangeView = [[BNDateRangeView alloc]initWithFrame:self.contentView.bounds];
        _dateRangeView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _dateRangeView;
}
@end
