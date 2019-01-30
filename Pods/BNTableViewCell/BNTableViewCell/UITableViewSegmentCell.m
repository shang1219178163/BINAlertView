//
//  UITableViewSegmentCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewSegmentCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIView+Helper.h"
#import "NSString+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


/**
 文字+segment
 */
@implementation UITableViewSegmentCell

- (void)dealloc
{
    [self.labelLeft removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.labelLeft];
        [self.contentView addSubview:self.segmentCtl];
        self.ctlAlignment = NSTextAlignmentCenter;
        
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
    
    CGFloat width = self.contentView.sizeWidth - self.labelLeft.maxX - kX_GAP;
    CGFloat ctlWidth = width*0.7;
    switch (self.ctlAlignment) {
        case NSTextAlignmentLeft:
        {
            [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelLeft);
                make.left.equalTo(self.labelLeft.right).offset(kPadding);
                make.width.equalTo(ctlWidth);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;

        case NSTextAlignmentRight:
        {
            [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelLeft);
                make.right.equalTo(self.contentView).offset(-kX_GAP);
                make.width.equalTo(ctlWidth);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
            
        case NSTextAlignmentJustified:
        {
            [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelLeft);
                make.left.equalTo(self.labelLeft.right).offset(kPadding);
                make.right.equalTo(self.contentView).offset(-kX_GAP);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
            
        default:
        {
            [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelLeft);
                make.left.lessThanOrEqualTo(self.labelLeft.right).offset((width - ctlWidth)*0.5);
                make.width.greaterThanOrEqualTo(ctlWidth);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UISegmentedControl *)segmentCtl{
    if (!_segmentCtl) {
        _segmentCtl = [UIView createSegmentRect:CGRectZero items:@[@"是",@"否"] selectedIndex:0 type:@0];
        _segmentCtl.selectedSegmentIndex = 0;
        
    }
    return _segmentCtl;
}

@end
