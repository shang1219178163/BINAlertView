//
//  UITableViewCellDefault.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UITableViewCellDefault.h"
#import "NSString+Helper.h"

@implementation UITableViewCellDefault

-(void)dealloc{
    [self.defaultView.labelLeft removeObserver:self forKeyPath:@"text" context:nil];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.defaultView];
        
        [self.defaultView.labelLeft addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.defaultView.labelLeft.attributedText = [self.defaultView.labelLeft.text toAsterisk];;
        
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.defaultView.frame = self.contentView.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BNCellDefaultView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[BNCellDefaultView alloc]initWithFrame:self.bounds];
        _defaultView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    }
    return _defaultView;
}

@end
