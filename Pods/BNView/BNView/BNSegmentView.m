//
//  BNSegmentView.m
//  BNAlertView
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 SouFun. All rights reserved.
//

#import "BNSegmentView.h"

#import "BNGloble.h"
#import "BNCategory.h"

@implementation BNSegmentView

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"type" context:nil];
    [self.indicator removeObserver:self forKeyPath:@"frame" context:nil];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.segmentCtl];
        [self addSubview:self.indicator];
        
        [self addObserver:self forKeyPath:@"type" options: NSKeyValueObservingOptionNew context:nil];
        [self.indicator addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
        self.indicatorHeight = 0.5;
        self.type = 0;
      
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat segmentWidth = CGRectGetWidth(self.bounds)/self.segmentCtl.numberOfSegments;
    switch (self.type) {
        case 1:
        {
            self.segmentCtl.frame = CGRectMake(0, self.indicatorHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - self.indicatorHeight);
            self.indicator.frame = CGRectMake(self.segmentCtl.minX, self.segmentCtl.minY - self.indicatorHeight, segmentWidth, self.indicatorHeight);
            
        }
            break;
        case 2:
        {
            self.segmentCtl.frame = self.bounds;
            self.indicator.frame = CGRectMake(self.segmentCtl.minX, self.segmentCtl.minY, segmentWidth, CGRectGetHeight(self.segmentCtl.frame));
        }
            break;
        default:
        {
            self.segmentCtl.frame = CGRectMake( 0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - self.indicatorHeight);
            self.indicator.frame = CGRectMake( self.segmentCtl.minX, self.segmentCtl.maxY + self.indicatorHeight, segmentWidth,  self.indicatorHeight);
            
        }
            break;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect rect = [change[NSKeyValueChangeNewKey] CGRectValue];
        if (CGRectGetHeight(rect) == self.indicatorHeight) {
            self.indicator.backgroundColor = UIColor.themeColor;
            
        } else {
            self.indicator.backgroundColor = UIColor.clearColor;
            self.indicator.layer.borderColor = UIColor.themeColor.CGColor;
            self.indicator.layer.borderWidth = self.indicatorHeight;
            
        }
        
    } else if ([keyPath isEqualToString:@"type"]){
        [self setNeedsLayout];
        
    } else {
        NSLog(@"keyPath无法监听");
    }
    
}


-(UISegmentedControl *)segmentCtl{
    if (!_segmentCtl) {
        _segmentCtl = [UIView createSegmentRect:CGRectZero items:@[@"item0",@"item1",@"item2"] selectedIndex:0 type:@2];
        @weakify(self)
        [_segmentCtl addActionHandler:^(UIControl * _Nonnull obj) {
            @strongify(self)
            UISegmentedControl * sender = (UISegmentedControl *)obj;
            CGFloat segmentWidth = CGRectGetWidth(self.bounds)/self.segmentCtl.numberOfSegments;

            [UIView animateWithDuration:kDurationShow animations:^{
                CGRect rect = self.indicator.frame;
                rect.origin.x = sender.minX + sender.selectedSegmentIndex * segmentWidth;
                self.indicator.frame = rect;
            }];
            
        } forControlEvents:UIControlEventValueChanged];
    }
    return _segmentCtl;
}

-(UIView *)indicator{
    if (!_indicator) {
        _indicator = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _indicator;
}

@end
